[README.md](https://github.com/user-attachments/files/33601624/README.md)
<div align="center">

**Language:** [English](README.md) · [فارسی](README.fa.md)

```
███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗███╗   ██╗███████╗████████╗
████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝████╗  ██║██╔════╝╚══██╔══╝
██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗██╔██╗ ██║█████╗     ██║
██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║██║╚██╗██║██╔══╝     ██║
██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║██║ ╚████║███████╗   ██║
╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝   ╚═╝
```

# NexusNet Node

**One VPS, many exit countries.** Multi-location Tor exit-node manager with first-class
**3X-UI (Sanaei) · Pasargad · Marzban** integration and a built-in **Telegram health bot**.

[![Version](https://img.shields.io/badge/version-3.0.0-blue?style=for-the-badge)](#)
[![Python](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![Platform](https://img.shields.io/badge/Ubuntu%20%7C%20Debian-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)](#requirements)
[![Telegram](https://img.shields.io/badge/Telegram-NexusNet-26A5E4?style=for-the-badge&logo=telegram&logoColor=white)](#)

</div>

---

## Why NexusNet?

NexusNet turns a **single VPS** into a fleet of Tor instances, each **pinned to a different exit country**
(51 locations), then wires them into your proxy panel — inbound, SOCKS outbound, routing rule and host —
so your users can pick "🇩🇪 Germany", "🇹🇷 Turkey", "🇳🇱 Netherlands"… from one subscription.

| | |
|---|---|
| 🌍 **51 locations** | fixed, predictable SOCKS ports per country |
| 🔌 **3 panels** | 3X-UI (Sanaei) · Pasargad · **Marzban** (new, fully automated) |
| 🤖 **Telegram health bot** | ping every node, instant alerts when one dies, one-tap restart |
| 🛠 **Auto-heal** | a node that stays down is restarted automatically (rate limited) |
| 🔄 **NEWNYM on restart** | fresh circuit / exit IP |
| 🧹 **Clean delete** | removes the service **and** the panel config (exact-tag matching only) |
| 💾 **Backup / restore** | node list + ports in one file |

---

## Quick start

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh)
```

then, any time:

```bash
sudo nxt-node
```

> `nexusnet` and `panel-tools` still work as aliases, so upgrading from v2.x changes nothing for you.
> Existing nodes are **not** touched by the upgrade.

### Requirements

| Item | Recommendation |
|------|----------------|
| OS | Ubuntu 20.04+ / Debian 11+ (apt) |
| CPU / RAM | 2+ cores / 4 GB+ (each node is one Tor process) |
| Python | 3.8+ (installed automatically) |
| Access | root |
| Panel | 3X-UI, Pasargad or Marzban on **the same server** |

> **Latency:** the ping you see is a full request through a Tor circuit (typically 0.3 – 2 s), not an ICMP ping.
> **Exit IPs:** countries with few exit relays may show a stable IP.

---

## Menu

```
 [1]  Install Engine           [9]  Check Node Latency
 [2]  Update System            [10] Restart All Nodes
 [3]  Uninstall System         [11] Show Active Ports
 [4]  Add Location Node        [12] Quick Country Test
 [5]  Bulk Add Nodes           [13] Delete All Nodes
 [6]  View Active Nodes        [14] System Status
 [7]  Edit or Delete Nodes     [15] Backup / Restore
 [8]  Advanced Port Settings   [16] Panel Tools (3X-UI / Pasargad / Marzban)
 [17] Health Monitor & Telegram Bot      [18] Health Check Now
```

### Command line

```bash
nxt-node                 # interactive menu
nxt-node health          # probe every node once (exit code 1 if any is down)
nxt-node health de --geo # one node, also verify the exit country
nxt-node health --json   # machine readable
nxt-node bot setup       # connect the Telegram bot
nxt-node bot status|start|stop|restart|logs|test
nxt-node panels          # Panel Tools
nxt-node update
```

---

## 🤖 Telegram bot & health monitor

Connect a bot exactly like the bots of Sanaei / Pasargad panels: **token + admin ID, done.**

1. Create a bot with [@BotFather](https://t.me/BotFather) and copy the token.
2. Open your bot and press **Start**. Get your numeric ID from [@userinfobot](https://t.me/userinfobot).
3. `nxt-node` → **17** → **1** and paste both. A test message is sent and the service is enabled.

**What it does**

* Probes every node every 2 min (configurable): systemd unit → SOCKS port → Tor bootstrap/circuit →
  real HTTP request through the node (the *ping*) → optional exit-country check.
* Sends **grouped** alerts (one message, not 40) after N consecutive failures, and a **recovery** message with the downtime.
* Tells you when the **VPS itself** has no internet (so you don't chase 51 "dead" nodes).
* **Auto-heal:** restarts a node that stays down (max 3/hour/node by default).
* Reminders for nodes that stay down, optional slow-node alerts, optional daily report.

**Bot commands** (admins only)

| Command | |
|---|---|
| `/status` | all nodes with ping |
| `/down` | only problem nodes + reason |
| `/ping [cc]` | live check of all nodes or one |
| `/node de` | details: service, port, bootstrap %, exit IP, error |
| `/restart [cc]` · `/restart_all` | restart (with confirmation for "all") |
| `/newnym cc\|all` | request a new Tor circuit |
| `/system` · `/ip` | uptime, load, RAM, disk · public IP |
| `/settings` · `/mute 60` · `/unmute` · `/interval 120` | alert control |

Buttons are available on every message. Messages are in **فارسی** or **English** (chosen at setup).

<details><summary><b>Advanced settings</b> (<code>/etc/nexusnet/config.json</code>)</summary>

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
Most values can be changed from the menu (17 → 5) or the bot (`/settings`, `/interval`, `/mute`).
After editing by hand: `nxt-node bot restart`. If api.telegram.org is blocked on your server, set `bot.proxy`
(e.g. `socks5h://127.0.0.1:9081`, through one of your own nodes).

**Node status:** 🟢 UP (≤ `slow_ms`) · 🟡 SLOW · 🟠 ERROR (unit and port fine, but nothing comes back through Tor / wrong exit country) · 🔴 DOWN (unit inactive or port closed).
Alerts fire only after `fail_threshold` consecutive bad probes.
</details>

---

## Panels

`nxt-node` → **16** (or `nxt-node panels`). For each node it creates, in the panel:

`inbound (cloned from one you choose, new port)` → `SOCKS outbound 127.0.0.1:<node port>` → `routing rule` → `host`

| Panel | Method | Notes |
|---|---|---|
| **3X-UI / Sanaei** | panel API + local DB | |
| **Pasargad** | panel API | credentials asked once, stored `0600` |
| **Marzban** | panel API | **one Xray restart for any number of nodes**; tags are `NexusNet-XX` |

**Marzban notes:** use a *sudo* admin; Xray must reach `127.0.0.1:<node port>` (the official docker-compose uses
`network_mode: host`, which works); create at least one host on the inbound you want to clone first; users with an
explicit inbound list must be allowed the new `NexusNet-XX` inbounds. Credentials are saved in `/etc/nexusnet/panels.json` (`0600`).

Safety rules (all panels): foreign inbounds are **never** deleted or modified — if the preferred port is
taken, the node is skipped (3X-UI/Pasargad) or moved to the next free port (Marzban); deletion matches **exact tags only**.

---

## Security

* Tor SOCKS ports now bind to **127.0.0.1** by default (panels run on the same server).
  Need a remote panel? `NXT_SOCKS_BIND=0.0.0.0 nxt-node` before creating nodes **and firewall the ports**.
* The bot token and panel passwords live in `/etc/nexusnet/` (`0700`, files `0600`).
* The bot answers **only** the configured admin IDs; everyone else gets a single "access denied".


---

## Credits

Based on the T.Sin idea · Developed by **KeEn** · Community: **NexusNet** on Telegram.

## License

[MIT](LICENSE).
