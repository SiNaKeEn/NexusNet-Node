[README.md](https://github.com/user-attachments/files/33605599/README.md)
<div align="center">

# NexusNet Node

**One VPS · many exit countries.**  
Multi-location Tor exit-node manager with first-class panel integration and a Telegram health bot.

![version](https://img.shields.io/badge/version-3.5.0-22d3ee?style=for-the-badge&labelColor=0b1220)
![python](https://img.shields.io/badge/Python-3.8%2B-3776AB?style=for-the-badge&labelColor=0b1220)
![os](https://img.shields.io/badge/Ubuntu%20%C2%B7%20Debian-E95420?style=for-the-badge&labelColor=0b1220)
![panels](https://img.shields.io/badge/3x--ui%20%C2%B7%20Pasargad%20%C2%B7%20Marzban-supported-2563eb?style=for-the-badge&labelColor=0b1220)
![bot](https://img.shields.io/badge/Telegram-health%20bot-26A5E4?style=for-the-badge&labelColor=0b1220)

**English** · [فارسی](README.fa.md)

</div>

---

## ✨ Highlights

| | |
|---|---|
| 🌍 **51 exit locations** | Germany, Netherlands, Turkey, US, UK… each on its own SOCKS port, pinned with `ExitNodes {cc}` |
| 🔌 **Three panels** | **3X-UI (Sanaei)** · **Pasargad** · **Marzban** — inbound, SOCKS outbound, routing and host in one pass |
| 🤖 **Telegram health bot** | Probes every node, grouped alerts when something dies, one-tap restart from the chat |
| 🛠 **Auto-heal** | A node that stays down is restarted automatically (rate-limited per hour) |
| 🔄 **NEWNYM on restart** | Fresh Tor circuit / exit IP every time you restart |
| 🧹 **Clean delete** | Removes the local service **and** the matching panel config (exact tag only — your other inbounds stay safe) |
| 💾 **Backup / restore** | Node list + ports in one file; restore rebuilds what’s missing |
| 📍 **Smart host address** | Keep source domain, use server public IP, or type a custom one when cloning hosts |

---

## 🚀 Install

> Requirements: Linux (**root**), Ubuntu / Debian, and ideally your panel on the **same** server.

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh)
```

That installs `nxt-node` and opens the menu. Next time:

```bash
sudo nxt-node
```

Aliases from older versions still work: `nexusnet`, `NexusNet`, `panel-tools`.

<details>
<summary><b>If you hit <code>Argument list too long</code></b></summary>

```bash
curl -sL "https://raw.githubusercontent.com/SiNaKeEn/NexusNet-Node/Multi/install.sh" -o /tmp/install.sh && sudo bash /tmp/install.sh
```
</details>

<details>
<summary><b>Requirements</b></summary>

| Item | Recommendation |
|------|----------------|
| OS | Ubuntu 20.04+ / Debian 11+ |
| CPU / RAM | 2+ cores · 4 GB+ |
| Server location | **Germany** or **Netherlands** work best for Tor exits |
| Panel | 3X-UI, Pasargad or Marzban on the same machine |
| Access | Root (`sudo`) |

Ping and path quality still depend on the end-user’s network, not only the VPS.
</details>

---

## 🖥 Menu

```
┌────────────────────────────────────────────────────────┐
│  N E X U S N E T  -  Multi Node                        │
│  v3.5.0  ·  Tor exit nodes for your panels             │
├────────────────────────────────────────────────────────┤
│  [ 1] Install Engine          [ 9] Check Node Latency  │
│  [ 2] Update System           [10] Restart All Nodes   │
│  [ 3] Uninstall System        [11] Show Active Ports   │
│  [ 4] Add Location Node       [12] Quick Country Test  │
│  [ 5] Bulk Add Nodes          [13] Delete All Nodes    │
│  [ 6] View Active Nodes       [14] System Status       │
│  [ 7] Edit or Delete Nodes    [15] Backup / Restore    │
│  [ 8] Advanced Port Settings  [16] Panel Tools         │
│  [17] Health Monitor & Bot    [18] Health Check Now    │
│  [ 0] Exit                                             │
└────────────────────────────────────────────────────────┘
```

### Command line

```bash
nxt-node                 # interactive menu
nxt-node health          # probe every node once (exit 1 if any is down)
nxt-node health de --geo # one country + exit-country check
nxt-node health --json   # machine-readable
nxt-node bot setup       # connect the Telegram bot
nxt-node bot status|start|stop|restart|logs|test
nxt-node panels          # Panel Tools (3X-UI / Pasargad / Marzban)
nxt-node update          # self-update
```

---

## 🤖 Telegram health bot

<div align="center">

The bot watches every node on a schedule, alerts you when something fails, and can restart them from chat.

</div>

### Setup

1. Talk to [@BotFather](https://t.me/BotFather) → create a bot → copy the **token**.
2. Talk to [@userinfobot](https://t.me/userinfobot) → copy your **numeric user ID**.
3. `nxt-node` → **17** → **1** and paste both. A test message is sent and the service is enabled.

Or:

```bash
sudo nxt-node bot setup
```

### Commands (admins only)

| Command | What it does |
|---------|----------------|
| `/status` | Status + ping for every node |
| `/down` | Only problem nodes + reason |
| `/ping [cc]` | Live check, all or one country |
| `/node de` | Detail: service, port, bootstrap %, exit IP, error |
| `/restart [cc]` · `/restart_all` | Restart (asks confirm for “all”) |
| `/newnym cc\|all` | New Tor circuit |
| `/system` · `/ip` | Uptime, load, RAM, disk · public IP |
| `/settings` · `/mute 60` · `/unmute` · `/interval 120` | Alert controls |

Bot language (Persian / English) is chosen at setup.  
Inline keyboard buttons work for status, problems, ping, system, restart and settings.

<details>
<summary><b>What the monitor checks</b></summary>

Every interval (default **120 s**, adjustable):

1. systemd service state  
2. SOCKS port listening  
3. Tor bootstrap %  
4. Real HTTP request **through** the node (= “ping”)  
5. Optional exit-country match (`geo_check`)

Then:

- **Grouped** down / recovered alerts (one message, not forty)
- Detects “the VPS itself has no internet” so you don’t chase 51 false failures
- Auto-restart of stuck nodes (default max **3/hour** per node)
- Optional slow-node alerts, still-down reminders, daily report

Config lives in `/etc/nexusnet/config.json` (mode `0600`). After hand-edits: `nxt-node bot restart`.  
If `api.telegram.org` is blocked on the server, set `bot.proxy` to an HTTP/SOCKS proxy.
</details>

---

## 🧩 Panel Tools

`nxt-node` → **16** (or `nxt-node panels`).

For each node the tool creates:

**Inbound** (clone of the source you pick, new port) → **SOCKS outbound** to `127.0.0.1:<node port>` → **routing rule** → **host**

| Panel | Method | Notes |
|-------|--------|-------|
| **3X-UI (Sanaei)** | Panel API + local DB | |
| **Pasargad** | Panel API | Username / password asked once, stored `0600` |
| **Marzban** | Panel API | **One Xray restart** for any number of nodes; tags `NexusNet-XX` |

<details>
<summary><b>Marzban tips</b></summary>

- Log in as a **sudo** admin  
- Xray must reach `127.0.0.1:<node port>` (official compose with `network_mode: host` works)  
- Create at least one host on the inbound you want to clone  
- Users with an explicit inbound list need the new `NexusNet-XX` tags added  

Safety rule: your non-NexusNet inbounds are **never** deleted or rewritten.  
If a port is taken, that node is skipped (3X-UI / Pasargad) or moved to the next free port (Marzban).  
Delete matches **exact tags only**.
</details>

---

## 📦 Typical workflow

1. **Install engine** (menu `1`)  
2. **Add nodes** — one location (`4`) or bulk (`5`)  
3. **Panel Tools** (`16`) — clone inbound + host for each country  
4. **Health bot** (`17`) — optional, for alerts and remote restart  
5. **Latency / restart / backup** as needed (`9` · `10` · `15`)

Edit / delete (`7`) supports single and multi select:

```
1          → one node
1,3,5      → several
1-10       → a range
```

---

## 🔒 Security

| Topic | Behavior |
|-------|----------|
| SOCKS bind | Default **127.0.0.1** only. For a remote panel: `NXT_SOCKS_BIND=0.0.0.0` **and a firewall** |
| Secrets | Bot token & panel passwords under `/etc/nexusnet/` (`0700` / `0600`) |
| Bot access | Answers **admin IDs only** |
| Panel deletes | Exact tag match — never mass-wipes your panel |

---

## ❓ FAQ

<details>
<summary><b>Upgrade from v2.x?</b></summary>
Run the same install command. Existing nodes are left alone. Commands <code>nexusnet</code> / <code>panel-tools</code> keep working.
</details>

<details>
<summary><b>Ping is high (200–250 ms)?</b></summary>
That is mostly path + Tor circuit quality. Prefer a VPS in <b>DE</b> or <b>NL</b>. Restart nodes (menu <code>10</code> or <code>/restart_all</code>) to request new circuits.
</details>

<details>
<summary><b>Host not created on Pasargad?</b></summary>
Pasargad expects <code>address</code> / <code>host</code> as a <b>list</b> of strings. Recent NexusNet versions send the correct format. Update if you are on an older build.
</details>

<details>
<summary><b>Bot menu appears by itself / buttons do nothing?</b></summary>
Restart the service after setup: <code>sudo nxt-node bot restart</code>. Confirm your numeric Telegram ID is in the admin list. Open the bot once and press <b>Start</b>.
</details>

<details>
<summary><b>Uninstall everything?</b></summary>
Menu <code>3</code> — removes NexusNet services and packages. Panel configs created by Panel Tools can be cleaned from option <code>7</code> / Panel Tools when available.
</details>

---

## 🙏 Credits

Built on the original idea by **T.Sin**  
Upgraded & maintained by **SiNa (KeEn)**  

Telegram: [NexusNet](https://t.me/NexusNet_Plus)

## License

[MIT](LICENSE)
