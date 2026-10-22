[Uploading README.md…]()
<div align="center">

<img src="assets/banner.svg" alt="NexusNet Node" width="100%">

<br>

**One VPS · many exit countries.**
Tor exit-node manager for **3X-UI (Sanaei) · Pasargad · Marzban** — with a Telegram control bot, remote VPS support and fleet monitoring.

<br>

![version](https://img.shields.io/badge/version-5.0.0-22d3ee?style=for-the-badge&labelColor=0b1220)
![python](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=for-the-badge&labelColor=0b1220)
![os](https://img.shields.io/badge/Ubuntu%20%C2%B7%20Debian-E95420?style=for-the-badge&labelColor=0b1220)
![panels](https://img.shields.io/badge/3x--ui%20%C2%B7%20Pasargad%20%C2%B7%20Marzban-supported-2563eb?style=for-the-badge&labelColor=0b1220)
![bot](https://img.shields.io/badge/Telegram-control%20bot-26A5E4?style=for-the-badge&labelColor=0b1220)
![license](https://img.shields.io/badge/license-MIT-16a34a?style=for-the-badge&labelColor=0b1220)

**English** · [فارسی](README.fa.md)

[Install](#-install) · [Terminal menu](#-terminal-menu) · [Telegram bot](#-telegram-bot) · [Remote VPS](#-remote-vps) · [Fleet](#-fleet) · [Backup](#-backup--move-to-a-new-vps) · [Panels](#-panels)

</div>

---

## ✨ What is it?

NexusNet turns **one VPS** into a fleet of Tor instances, each **pinned to a different exit country** (51 locations), then wires them into your
proxy panel — *inbound → SOCKS outbound → routing rule → host* — so your users can pick 🇩🇪 Germany, 🇹🇷 Turkey, 🇳🇱 Netherlands… from a single subscription.

| | |
|---|---|
| 🌍 **51 locations** | a fixed, predictable SOCKS port per country |
| 🔌 **3 panels** | 3X-UI (Sanaei) · Pasargad · Marzban — Marzban gets one Xray restart however many nodes you add |
| 🖥 **Remote VPS** | install Tor **on your Pasargad worker nodes** over SSH, into the core, inbound and host **you choose** |
| 🌐 **Fleet** | master + every VPS on one dashboard · **Smart Heal** · update / restart all · background watch with alerts |
| 🤖 **Telegram bot** | everything the terminal can do — nodes, panels, remote VPS (add / edit / delete), fleet, backup — from your phone |
| 📦 **Backup & migration** | one file → new server: engine, nodes with the **same ports**, settings and panel wiring; daily backup to Telegram |
| 🛠 **Auto-heal** | a node that stays down is restarted automatically (rate-limited) |
| 🩺 **Doctor** | finds the usual causes: wrong clock, missing GeoIP, port clashes, exposed proxies, blocked Telegram |
| 🧹 **Safe delete** | removes the service **and** its panel config — exact tags only, your own inbounds are never touched |

---

## 🚀 Install

> Linux, **root**, Ubuntu / Debian. The panel should be on the **same** server (remote nodes are covered by [Remote VPS](#-remote-vps)).

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh)
```

The installer is one self-contained file. Next time just run:

```bash
sudo nxt-node
```

`nexusnet`, `NexusNet` and `panel-tools` still work. Upgrading keeps your nodes untouched.

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
 │       v5.0.0  ·  Tor exit nodes for your panels        │
 └────────────────────────────────────────────────────────┘
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
nxt-node health [de] [--geo] [--json]            # probe through Tor (exit code 1 if any node is bad)
nxt-node fleet [--live] [--heal] [--json]        # master + all remote VPS (exit code 1 on problems)
nxt-node backup [-o FILE] [--secrets] [--send]   # backup file (+ send to Telegram)
nxt-node restore FILE [-y] [--no-wire]           # restore / migrate on THIS server
nxt-node doctor               # diagnose problems
nxt-node bot setup|start|stop|restart|status|logs|test
nxt-node panels               # Panel Tools
nxt-node update
```

---

## 🤖 Telegram bot

Connect it like the bots of Sanaei / Pasargad: **token + admin ID, done.**

1. Create a bot with [@BotFather](https://t.me/BotFather) → copy the **token**.
2. Open your bot and press **Start**. Get your numeric ID from [@userinfobot](https://t.me/userinfobot).
3. `nxt-node` → **10** → **1** → paste both (language: Farsi / English). A test message is sent and the service is enabled.

If Telegram is blocked on your server, setup asks for an optional proxy (used **only** for `api.telegram.org`).

### The menu

```
🌐 NexusNet Node · v5.0.0
━━━━━━━━━━━━━━━━━━━━
🟢 11 online · 🟡 1 slow · 🔴 1 down
⚡ Avg ping 640 ms · 🕒 checked 42s ago
━━━━━━━━━━━━━━━━━━━━
💻 Load 0.42 · RAM 41% · Up 12d

   ━━ 📊 MONITORING ━━
 [📊 Status] [🚨 Problems] [🏓 Ping all]
   ━━ 🌍 NODES ━━
 [🌍 Nodes] [➕ Add node] [🧩 Panels]
   ━━ 🖥 REMOTE VPS ━━
 [🖥 Remote VPS] [🌐 Fleet] [➕ Add VPS]
   ━━ 🧰 TOOLS ━━
 [📦 Backup] [💻 System] [⚙️ Settings]
```

* **One message, always** — every button *edits* the same message; no chat spam. `/start` replaces the old menu.
* **Alerts with buttons** — a down-alert carries `🔄 DE  🔄 TR …` buttons: restart the broken node straight from the alert.
* **Nodes** — grid with live status → details, 🏓 ping, 🔄 restart, 🔁 new circuit, 🔗 wire to panel, 🗑 delete (with confirmation). **☑️ Select** several and Create / Restart / Wire / Delete in one go.
* **Remote VPS** — the same options as the terminal VPS menu, one-to-one (see below), including **➕ Add VPS** and **✏️ Edit VPS**.
* **Backup** — 📤 send now, 📅 daily auto-backup, and **send a `.nxtbak` file to the bot to restore**.
* **Panels** — wire nodes into 3X-UI / Pasargad / Marzban. **Panel passwords are never typed into Telegram** — save the login once with `nxt-node panels`.
* **Settings** — auto-heal, slow alerts, exit-country check, daily report, interval, alert threshold, mute, language فارسی ⇄ English.

Text shortcuts: `/start /status /down /ping [cc] /nodes /node cc /restart cc /newnym cc|all /add [cc] /panels /backup /system /settings /mute 60 /unmute /interval 120 /cancel /help`

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
  },
  "remote": {"watch": true, "interval_sec": 300, "fail_threshold": 2, "auto_heal": true, "heal_max_per_hour": 3}
}
```

**Node status:** 🟢 UP · 🟡 SLOW (> `slow_ms`) · 🟠 ERROR (service and port fine, but nothing comes back through Tor, or wrong exit country) · 🔴 DOWN (unit inactive / port closed).
Alerts fire only after `fail_threshold` consecutive bad probes. After editing by hand: `nxt-node bot restart`.
</details>

---

## 🖥 Remote VPS

Pasargad worker nodes are usually bare servers. NexusNet installs Tor **on the node itself** over SSH, so the core's Xray reaches it on `127.0.0.1`
(no open ports, nothing exposed). `nxt-node` → **21**, or the bot → 🖥 Remote VPS.

**First screen:** your saved VPS with `up/total`, plus **Add / Edit / Delete / Test SSH**. Pick one and a menu laid out like the main menu opens — every item runs on that VPS:

| Menu item | What it does |
|---|---|
| **Install / Update NexusNet** | installs NexusNet + Tor over SSH (re-installs if already there) |
| **Add Node · Bulk Deploy** | **you choose** core → countries → inbound → host template, then the nodes are created and wired into that core (one panel save, host address = the VPS) |
| **List Nodes · Health Check** | node list; health check adds ping and the **exit IP** of every node |
| **Edit / Delete Nodes** | deletes on the VPS **and** removes inbound / outbound / rule / host from the panel core |
| **Doctor · Active Ports · System Status** | the same diagnostics as the main menu, run on that VPS |
| **Restart All / One · New Circuits · Node Logs** | exactly what they say |
| **Smart Heal** | restarts what is down, new circuit where the exit is wrong or duplicated |
| **Select Core · Wire to Panel** | a VPS can be several panel nodes with different cores — **all** are listed (the VPS's own first, then every other core); re-wire nodes that are already installed |
| **Edit VPS · Test SSH · Remove VPS · Delete All Nodes** | manage the saved server |

**Adding a VPS** — with Pasargad connected you pick one of **its nodes** and only give the SSH login. In the bot it is a short chat wizard
(*node → login → password*); your password message is **deleted immediately** and stored only on the server (`0600`). SSH keys are supported (use the default keys).

---

## 🌐 Fleet

`nxt-node` → **21** → **F**, or the bot → 🖥 Remote VPS → 🌐 Fleet.

* **Dashboard** — master + all VPS on one screen: nodes up / total, average ping, problems. **Live Check** probes through Tor and finds what
  "service is active" misses: **wrong exit country** and **duplicate exit IPs**.
* **Smart Heal** — per VPS or **Heal All**: restarts nodes that are down, asks Tor for a **new circuit** where the exit is wrong or duplicated. Nothing is touched when nothing is wrong.
* **Update All / Restart All VPS** — the same action on every VPS in parallel (asks first).
* **Background watch** — the bot reads every VPS every 5 minutes (one SSH call each) and alerts you: unreachable · nodes down · healed · healthy again.
  Down nodes are restarted automatically (max 3×/hour per VPS). Configure under `"remote"` in `config.json`.
* **For cron / scripts** — `nxt-node fleet [--live] [--heal] [--json]` (exit code 1 when something is wrong).

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

1. **Engine** — installs Tor + GeoIP if needed
2. **Nodes** — recreated with the **same SOCKS / control ports** (existing nodes are kept)
3. **Settings** — alert / monitor settings (bot token only if the file includes secrets and you allow it)
4. **Panel wiring** — finds your inbound and host **by name** in the new panel and wires every node in one batch
5. **Health check** — waits for the nodes to bootstrap and reports 🟢 / 🔴

**Without a terminal:** set up the bot on the new server (`nxt-node bot setup`) and **send the `.nxtbak` file to the bot** — it shows a plan and a *Restore now* button.
Turn on **📅 Auto backup** and a fresh file lands in your chat every night.

> The panel itself (users, inbounds) must exist on the new server — restore the panel's own backup first. Panel passwords are not in the file:
> if a panel says *login needed*, run `nxt-node panels` once.

---

## 🧩 Panels

`nxt-node` → **20**, or `nxt-node panels`. For each node NexusNet creates in the panel:

`inbound (cloned from one you choose, new port)` → `SOCKS outbound 127.0.0.1:<node port>` → `routing rule` → `host`

| Panel | Method | Notes |
|---|---|---|
| **3X-UI / Sanaei** | panel API + local DB | |
| **Pasargad** | panel API | login asked once, stored `0600`; multi-core aware |
| **Marzban** | panel API | one Xray restart for any number of nodes; tags `NexusNet-XX` |

**Marzban:** use a *sudo* admin; Xray must reach `127.0.0.1:<node port>` (the official docker-compose uses `network_mode: host`, which works);
create at least one host on the inbound you want to clone first; users with an explicit inbound list must be allowed the new `NexusNet-XX` inbounds.

**Safety rules (all panels):** foreign inbounds are **never** deleted or modified — if the preferred port is taken the node is skipped
(3X-UI / Pasargad) or moved to the next free port (Marzban); deletion matches **exact tags only**.

---

## 🔒 Security

* Tor SOCKS ports bind to **127.0.0.1** by default. A remote panel? `NXT_SOCKS_BIND=0.0.0.0` **and a firewall**. `nxt-node doctor` warns about exposed ports.
* Bot token, panel logins and VPS SSH logins live in `/etc/nexusnet/` (dir `0700`, files `0600`). Never paste them in issues.
* The bot answers only the configured admin IDs; strangers get a single "access denied".
* Passwords typed in the bot (VPS SSH only) are deleted from the chat at once; prefer SSH keys. Panel passwords are never typed in Telegram.
* Backups sent through Telegram never contain tokens or passwords; the restore file is size-limited, checksum-verified and schema-validated.
* Delete and restart-all always ask for confirmation (`nxt-node delete` too, unless `-y`).

---

## 🛟 Troubleshooting

| Symptom | Try |
|---|---|
| Nodes never get online | `nxt-node doctor` (clock sync, GeoIP, RAM) · `nxt-node logs de` |
| Bot does not answer | `nxt-node bot logs` · `nxt-node doctor` (Telegram reachable?) · set a proxy in *Alert settings* |
| Setup says "chat not found" | open the bot and press **Start**, then *Send test message* |
| A panel is "login needed" in the bot | run `nxt-node panels` once in the server terminal |
| A remote VPS shows *check failed* | open it → **Install / Update NexusNet** (the VPS has an old `nxt-node`) |

---

## 🧱 Source code

`install.sh` carries the whole program. To read or edit it: `bash install.sh --extract` → `NexusNet-Node-src/`, then `python3 tools/build_installer.py` to rebuild.

## 💙 Credits

Based on the T.Sin idea · Developed by **KeEn** · Telegram channel: **NexusNet**

## 📄 License

[MIT](LICENSE)
