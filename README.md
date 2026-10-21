[README.md](https://github.com/user-attachments/files/33746386/README.md)
<div align="center">

# NexusNet Node

**One VPS · many exit countries.**
Multi-location Tor exit-node manager for **3X-UI (Sanaei) · Pasargad · Marzban** — with a Telegram control bot.

![version](https://img.shields.io/badge/version-4.5.0-22d3ee?style=for-the-badge&labelColor=0b1220)
![python](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=for-the-badge&labelColor=0b1220)
![os](https://img.shields.io/badge/Ubuntu%20%C2%B7%20Debian-E95420?style=for-the-badge&labelColor=0b1220)
![panels](https://img.shields.io/badge/3x--ui%20%C2%B7%20Pasargad%20%C2%B7%20Marzban-supported-2563eb?style=for-the-badge&labelColor=0b1220)
![bot](https://img.shields.io/badge/Telegram-control%20bot-26A5E4?style=for-the-badge&labelColor=0b1220)
![license](https://img.shields.io/badge/license-MIT-16a34a?style=for-the-badge&labelColor=0b1220)

**English** · [فارسی](README.fa.md)

</div>

---

## ✨ What is it?

NexusNet turns **one VPS** into a fleet of Tor instances, each **pinned to a different exit country** (51 locations),
then wires them into your proxy panel — inbound → SOCKS outbound → routing rule → host — so your users can pick
🇩🇪 Germany, 🇹🇷 Turkey, 🇳🇱 Netherlands… from a single subscription.

| | |
|---|---|
| 🌍 **51 locations** | fixed, predictable SOCKS port per country |
| 🔌 **3 panels** | 3X-UI (Sanaei) · Pasargad · **Marzban** — one Xray restart however many nodes you add |
| 🤖 **Telegram control bot** | dashboard, live ping, alerts with **one-tap restart**, add / delete nodes, wire to panels — all from your phone |
| 📦 **Backup & VPS migration** | one file → new server: engine, nodes with the **same ports**, settings and panel wiring restored in order; daily backup straight to your Telegram |
| ☑️ **Bulk from your phone** | select 10 countries at once, create them and wire them into the panel in one batch — same for delete / restart |
| 🛠 **Auto-heal** | a node that stays down is restarted automatically (rate-limited) |
| 🩺 **Doctor** | `nxt-node doctor` finds the usual causes: wrong clock, missing GeoIP, port clashes, exposed proxies, blocked Telegram |
| 🧹 **Safe delete** | removes the service **and** its panel config — exact tags only, your own inbounds are never touched |
| 💾 **Backup / restore** | node list + ports in one file |

---

## 🚀 Install

> Linux, **root**, Ubuntu / Debian. Your panel should be on the **same** server.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh)
```

The installer is a single self-contained file. Next time just run:

```bash
sudo nxt-node
```

`nexusnet`, `NexusNet` and `panel-tools` still work. Upgrading from an older version keeps your nodes untouched.

<details>
<summary><b>Requirements</b></summary>

| | |
|---|---|
| OS | Ubuntu 20.04+ / Debian 11+ |
| CPU / RAM | 2+ cores · 4 GB+ (each node is one Tor process, roughly 60 MB) |
| Python | 3.8+ (installed automatically) |
| Panel | 3X-UI, Pasargad or Marzban on the same machine |

The ping you see is a full request **through a Tor circuit** (typically 0.3 – 2 s), not an ICMP ping.
</details>

---

## 🖥 Terminal menu

```
 ┌────────────────────────────────────────────────────────┐
 │             N E X U S N E T  -  Multi Node             │
 │       v4.5.0  ·  Tor exit nodes for your panels        │
 └────────────────────────────────────────────────────────┘
 ┌────────────────────────────────────────────────────────┐
 │  System    : Active (12 nodes)                         │
 │  Bot       : active                                    │
 │  Nodes     : 11 up, 1 problem  (45s ago)               │
 ├─ SETUP ────────────────────────────────────────────────┤
 │   [ 1] » Install Engine                                │
 │   [ 2] » Update NexusNet                               │
 │   [ 3] » Uninstall NexusNet                            │
 ├─ NODES ────────────────────────────────────────────────┤
 │   [ 4] » Add Node                                      │
 │   [ 5] » Bulk Deploy                                   │
 │   [ 6] » List Nodes                                    │
 │   [ 7] » Edit / Delete Nodes                           │
 │   [ 8] » Port Settings                                 │
 ├─ MONITORING ───────────────────────────────────────────┤
 │   [ 9] » Health Check  (ping all nodes)                │
 │   [10] » Telegram Bot & Alerts                         │
 │   [11] » Doctor  (find what is broken)                 │
 │   [12] » Latency & Exit IP  (classic)                  │
 ├─ TOOLS ────────────────────────────────────────────────┤
 │   [13] » Restart All Nodes                             │
 │   [14] » Restart One Node                              │
 │   [15] » Node Logs                                     │
 │   [16] » Active Ports                                  │
 │   [17] » Quick Country Test                            │
 │   [18] » System Status                                 │
 │   [19] » Backup & Migrate  (move to a new VPS)         │
 ├─ PANELS ───────────────────────────────────────────────┤
 │   [20] » Panel Tools  (3X-UI / Pasargad / Marzban)     │
 │   [21] » Remote VPS  (Tor on Pasargad nodes, SSH)      │
 ├─ DANGER ZONE ──────────────────────────────────────────┤
 │   [22] » Delete All Nodes                              │
 ├────────────────────────────────────────────────────────┤
 │   [ 0] » Exit                                          │
 └────────────────────────────────────────────────────────┘
```

### Command line (scriptable)

```bash
nxt-node                      # interactive menu
nxt-node list [--json]        # installed nodes + service state
nxt-node add de nl tr         # create nodes   (or: nxt-node add --all)
nxt-node delete tr -y         # delete a node and its panel config
nxt-node restart all|de       # restart
nxt-node newnym de|all        # fresh Tor circuit / exit IP
nxt-node logs de -n 100       # a node's service log
nxt-node backup [-o FILE] [--secrets] [--send]   # backup file (+ send to Telegram)
nxt-node restore FILE [-y] [--no-wire]           # restore / migrate on THIS server
nxt-node health [de] [--geo] [--json]   # probe through Tor (exit code 1 if any node is bad)
nxt-node doctor               # diagnose problems
nxt-node bot setup|start|stop|restart|status|logs|test
nxt-node panels               # Panel Tools
nxt-node update
```

---

## 🤖 Telegram bot

Connect it exactly like the bots of Sanaei / Pasargad: **token + admin ID, done.**

1. Create a bot with [@BotFather](https://t.me/BotFather) → copy the **token**.
2. Open your bot and press **Start**. Get your numeric ID from [@userinfobot](https://t.me/userinfobot).
3. `nxt-node` → **10** → **1** → paste both (language: Farsi / English). A test message is sent and the service is enabled.

If Telegram is blocked on your server the setup asks for an optional proxy (used **only** for `api.telegram.org`).

### What you get

```
🌐 NexusNet Node · v4.5.0
━━━━━━━━━━━━━━━━━━━━
🟢 11 online · 🟡 1 slow · 🔴 1 down
⚡ Avg ping 640 ms · 🕒 checked 42s ago
━━━━━━━━━━━━━━━━━━━━
🖥 Load 0.42 · RAM 41% · Up 12d

 [📊 Status] [🚨 Problems] [🏓 Ping all]
 [🌍 Nodes]  [➕ Add node] [🧩 Panels]
 [🖥 System] [⚙️ Settings] [❓ Help]
```

* **One message, always** – every button *edits* the same message; no chat spam. `/start` replaces the old menu.
* **Alerts with buttons** – a down-alert carries `🔄 DE  🔄 TR …` buttons: restart the broken node straight from the alert.
* **Nodes** – grid with live status icons → tap a node for details, 🏓 ping, 🔄 restart, 🔁 new circuit, 🔗 wire to panel, 🗑 delete (with confirmation).
* **Select several** – `☑️ Select` on the Nodes screen (or ➕ Add): tick any number of countries/nodes (page, all, clear), then **Create / Restart / Wire to panel / Delete** them in one go. Panels get one batch (Marzban: a single Xray restart).
* **Add nodes** – pick e.g. 10 countries → *Tor only* or *Tor + panel* (inbound → host → address wizard) with live progress.
* **Backup** – 📤 send a backup file now, 📅 daily auto-backup to your chat, and **send a `.nxtbak` file to the bot to restore** (see below).
* **Panels** – wire existing nodes into 3X-UI / Pasargad / Marzban. **Panel passwords are never typed into Telegram** — save the login once with `nxt-node panels`.
* **Settings** – auto-heal, slow alerts, exit-country check, daily report, interval, alert threshold, mute 1h / 8h, language فارسی ⇄ English.
* Grouped alerts (one message, not 40), recovery messages with downtime, “still down” reminders, and a hint when the **VPS itself** has no internet.

Text shortcuts: `/start /status /down /ping [cc] /nodes /node cc /restart cc /newnym cc|all /add [cc] /panels /backup /system /settings /mute 60 /unmute /interval 120 /help`

<details>
<summary><b>Advanced settings</b> — <code>/etc/nexusnet/config.json</code></summary>

```json
{
  "bot": {"token": "...", "admin_ids": [123456789], "lang": "fa", "proxy": ""},
  "monitor": {
    "interval_sec": 120, "fail_threshold": 2, "timeout_sec": 10, "workers": 8,
    "good_ms": 800, "slow_ms": 2500, "alert_on_slow": false,
    "auto_heal": true, "heal_max_per_hour": 3, "reminder_min": 60,
    "geo_check": false, "geo_interval_min": 60, "daily_report_hour": -1
  }
}
```

**Node status:** 🟢 UP · 🟡 SLOW (> `slow_ms`) · 🟠 ERROR (service and port fine, but nothing comes back through Tor, or wrong exit country) · 🔴 DOWN (unit inactive / port closed).
Alerts fire only after `fail_threshold` consecutive bad probes. After editing by hand: `nxt-node bot restart`.
</details>

---

## 📦 Backup & move to a new VPS

The old server died? One file brings everything back.

**What is in a backup** (`.nxtbak`, JSON, checksum-protected): the node list **with ports**, monitor settings, and *how* nodes were wired into your panel
(which inbound, which host, address mode). **No passwords or tokens** unless you ask for them (`--secrets`, terminal only).

```bash
# old server (or Telegram bot → 📦 Backup → 📤 Send)
nxt-node backup                      # → /root/nexusnet-backups/nexusnet-<host>-<date>.nxtbak
nxt-node backup --send               # also uploads it to your Telegram admins

# NEW server
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh)
nxt-node restore nexusnet-....nxtbak
```

`restore` runs in this order and tells you what happened at each step:

1. **Engine** – installs Tor + GeoIP if needed
2. **Nodes** – recreated with the **same SOCKS/control ports** (existing nodes are kept)
3. **Settings** – alert/monitor settings (bot token only if the file includes secrets and you allow it)
4. **Panel wiring** – finds your inbound and host **by name** in the new panel and wires every node in one batch
5. **Health check** – waits for the nodes to bootstrap and reports 🟢 / 🔴

**Without a terminal:** set up the bot on the new server (`nxt-node bot setup`) and just **send the `.nxtbak` file to the bot** — it shows a plan and a *Restore now* button.
Turn on **📅 Auto backup** in the bot and a fresh file lands in your chat every night — a copy always exists even if the VPS vanishes.

> The panel itself (users, inbounds) must exist on the new server — restore the panel's own backup first. Panel passwords are not in the file:
> if a panel says *login needed*, run `nxt-node panels` once. Old v2.x text backups (`nexusnet_backup.txt`) can be restored too.

---

## 🧩 Panels

`nxt-node` → **20**, or `nxt-node panels`. For each node NexusNet creates in the panel:

`inbound (cloned from one you choose, new port)` → `SOCKS outbound 127.0.0.1:<node port>` → `routing rule` → `host`

| Panel | Method | Notes |
|---|---|---|
| **3X-UI / Sanaei** | panel API + local DB | |
| **Pasargad** | panel API | login asked once, stored `0600` |
| **Marzban** | panel API | one Xray restart for any number of nodes; tags `NexusNet-XX` |

**Marzban:** use a *sudo* admin; Xray must reach `127.0.0.1:<node port>` (the official docker-compose uses `network_mode: host`, which works);
create at least one host on the inbound you want to clone first; users with an explicit inbound list must be allowed the new `NexusNet-XX` inbounds.

**Safety rules (all panels):** foreign inbounds are **never** deleted or modified — if the preferred port is taken the node is skipped
(3X-UI / Pasargad) or moved to the next free port (Marzban); deletion matches **exact tags only**.

---

## 🖥 Remote VPS — Tor on your Pasargad nodes

Pasargad worker nodes are usually bare servers. NexusNet installs Tor **on the node itself** over SSH, so the core's
Xray reaches it on `127.0.0.1` (no open ports, nothing exposed). `nxt-node` → **21**.

**Terminal** — pick a server and you see *its* nodes exactly like the master list: country, SOCKS port, service state;
**Live check** adds ping and the **exit IP** of every node.

| Menu | What it does on the selected VPS |
|---|---|
| **1** Install / Update | installs NexusNet + Tor over SSH (updates if already there) |
| **2** Add Node · **3** Bulk Deploy | pick countries (`1,3,5-8`, `all`) → creates the Tor nodes and wires them into the node's core (one panel save, host address = the node) |
| **4** List · **6** Health Check | node list; health check adds ping and the **exit IP** of every node |
| **5** Edit / Delete | deletes nodes on the VPS **and** their inbound/outbound/rule/host in the panel core |
| **7** Doctor · **12** Ports · **13** System | the same diagnostics as the main menu, run on that VPS |
| **8–11** | restart all / one, new circuits, node logs |
| **14** Wire to Panel | re-wire nodes that are already installed |
| **15–17 · 18** | edit VPS, test SSH, remove from list · delete all nodes |

The first screen lists your saved VPS (`1/12 up`) with **Add / Edit / Delete / Test SSH**; a number opens a menu laid out exactly like the main one.

Adding a VPS: if Pasargad is connected you pick one of **its nodes** and only type the SSH password — the core is remembered.
Re-runs are fast: the installer is skipped when NexusNet is already there, and the last inbound/host template is reused.

**Telegram bot** — 🖥 *Remote VPS*: server list with `🟢 up/total`, tap a server → node list (service state), **📡 Live check** (ping + exit IPs),
**➕ Add countries / 🗑 Delete / 🔄 Restart** with a checkbox grid (delete always asks). SSH passwords are never typed in Telegram — add the VPS once in the terminal.

---

## 🔒 Security

* Tor SOCKS ports bind to **127.0.0.1** by default. A remote panel? `NXT_SOCKS_BIND=0.0.0.0` **and a firewall**. `nxt-node doctor` warns about exposed ports.
* Bot token and panel passwords live in `/etc/nexusnet/` (dir `0700`, files `0600`). Never paste them in issues.
* Backups sent through Telegram never contain tokens or passwords; the restore file is size-limited, checksum-verified and schema-validated before anything runs.
* The bot only answers the configured admin IDs; strangers get a single “access denied”.
* In the bot, delete and restart-all always ask for confirmation; `nxt-node delete` asks too unless you pass `-y`.

---

## 🛟 Troubleshooting

| Symptom | Try |
|---|---|
| Nodes never get online | `nxt-node doctor` (clock sync, GeoIP, RAM) · `nxt-node logs de` |
| Bot does not answer | `nxt-node bot logs` · `nxt-node doctor` (Telegram reachable?) · set a proxy in *Alert settings* |
| Setup says “chat not found” | open the bot and press **Start**, then *Send test message* |
| A panel is “login needed” in the bot | run `nxt-node panels` once in the server terminal |

---

## Source code

`install.sh` carries the whole program. To read or edit it: `bash install.sh --extract` → `NexusNet-Node-src/`, then `python3 tools/build_installer.py` to rebuild.

## Credits

Based on the T.Sin idea · Developed by **KeEn** · Telegram channel: **NexusNet**

## License

[MIT](LICENSE)
