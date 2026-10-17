#!/usr/bin/env bash
# NexusNet Node installer / updater
#   bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh)
# Env: NXT_REF=<branch|tag>  NXT_LOCAL_SRC=<dir> (install from a local checkout)  NXT_NO_LAUNCH=1
set -euo pipefail

REPO="${NXT_REPO:-SiNaKeEn/NexusNet-Node}"
REF="${NXT_REF:-Multi}"
PREFIX="/opt/nexusnet"
R=$'\e[1;31m'; G=$'\e[1;32m'; Y=$'\e[1;33m'; C=$'\e[1;36m'; N=$'\e[0m'

say()  { echo -e "${C}[*]${N} $*"; }
ok()   { echo -e "${G}[+]${N} $*"; }
die()  { echo -e "${R}[-]${N} $*" >&2; exit 1; }

[ "$(id -u)" -eq 0 ] || die "Run as root:  sudo bash install.sh"
command -v apt-get >/dev/null 2>&1 || die "Only Debian/Ubuntu (apt) are supported."

say "Installing system packages..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq python3 python3-requests python3-socks curl ca-certificates tar >/dev/null \
  || die "apt install failed"
python3 - <<'PY' || die "Python 3.8+ required"
import sys; sys.exit(0 if sys.version_info >= (3, 8) else 1)
PY
python3 -c "import requests, socks" 2>/dev/null || {
  say "apt packages incomplete, falling back to pip..."
  apt-get install -y -qq python3-pip >/dev/null
  pip3 install --quiet --break-system-packages requests "requests[socks]" 2>/dev/null \
    || pip3 install --quiet requests "requests[socks]"
}

TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
if [ -n "${NXT_LOCAL_SRC:-}" ]; then
  say "Using local source: $NXT_LOCAL_SRC"
  cp -a "$NXT_LOCAL_SRC" "$TMP/src"
else
  say "Downloading $REPO@$REF ..."
  curl -fsSL "https://github.com/$REPO/archive/$REF.tar.gz" -o "$TMP/src.tgz" \
    || die "Download failed (check NXT_REF / network)"
  mkdir "$TMP/src"; tar -xzf "$TMP/src.tgz" -C "$TMP/src" --strip-components=1
fi
[ -d "$TMP/src/nexusnet" ] || die "Invalid source tree (nexusnet/ missing)"

say "Installing to $PREFIX ..."
mkdir -p "$PREFIX"
rm -rf "$PREFIX/nexusnet"
cp -a "$TMP/src/nexusnet" "$PREFIX/nexusnet"
cp -a "$TMP/src/VERSION" "$PREFIX/VERSION" 2>/dev/null || true
find "$PREFIX" -name '__pycache__' -type d -prune -exec rm -rf {} + 2>/dev/null || true

cat > /usr/local/bin/nxt-node <<WRAP
#!/usr/bin/env python3
import sys
sys.path.insert(0, "$PREFIX")
from nexusnet.cli import main
sys.exit(main())
WRAP
chmod 755 /usr/local/bin/nxt-node
# Older command names keep working
for alias in nexusnet NexusNet; do ln -sf /usr/local/bin/nxt-node "/usr/local/bin/$alias"; done
cat > /usr/local/bin/panel-tools <<'WRAP'
#!/bin/sh
exec /usr/local/bin/nxt-node panels "$@"
WRAP
chmod 755 /usr/local/bin/panel-tools

install -d -m 700 /etc/nexusnet /var/lib/nexusnet

# Refresh the bot unit if the bot was already configured (keeps it on the new code)
if [ -f /etc/systemd/system/nexusnet-bot.service ]; then
  systemctl daemon-reload || true
  systemctl restart nexusnet-bot 2>/dev/null || true
fi

ok "NexusNet Node installed. Existing nodes were left untouched."
echo -e "    Open the menu with:  ${Y}nxt-node${N}"
if [ -z "${NXT_NO_LAUNCH:-}" ] && [ -t 0 ]; then
  sleep 1; exec /usr/local/bin/nxt-node
fi
