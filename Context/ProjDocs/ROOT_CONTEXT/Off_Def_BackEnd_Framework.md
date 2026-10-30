# Offensive & Defensive CyberSec Stack & Engineering Blueprint

A unified, 100% free and open-source security engineering lab specification optimized for **Pop!_OS** (Debian/Ubuntu LTS kernel base). This blueprint aggregates the 10 core offensive and defensive tools, analyzes the operational gaps between them, and outlines the architectural specifications for custom tooling built with **Rust, Go, Python, POSIX Shell, and HTMX**.

---

## 1. Offensive Stack (Bug Bounty & Vulnerability Research)

All tools in this layer are open-source, performant, and run natively on Pop!_OS via Go runtimes, package managers, or pre-compiled binaries.

| Tool | Category | License | Core Bounty Utility | Pop!_OS Installation |
| :--- | :--- | :--- | :--- | :--- |
| **ProjectDiscovery Nuclei** | Active Vulnerability Scanning | Apache 2.0 | Fast, community-driven YAML template engine used to probe targets for known CVEs, misconfigurations, default credentials, and out-of-band interactions (OAST). | `go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest` |
| **OWASP Amass** | Attack Surface Discovery & OSINT | Apache 2.0 | In-depth network mapping and external asset correlation using DNS enumeration, web scraping, ASN mapping, and graph database storage. | `go install -v github.com/owasp-amass/amass/v4/...@master` |
| **ffuf** | High-Speed Web Fuzzing | MIT | High-throughput web fuzzing for hidden endpoint discovery, virtual host routing, and parameter extraction with fine-grained regex and match filters. | `go install github.com/ffuf/ffuf/v2@latest` |
| **ProjectDiscovery httpx** | Service Probing & Fingerprinting | MIT | Fast multi-purpose HTTP probe to validate live endpoints, inspect TLS certificates, track redirects, and fingerprint server technology stacks. | `go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest` |
| **mitmproxy** | Interactive Proxy & Traffic Triage | MIT | Scriptable console proxy (`mitmproxy`), headless processor (`mitmdump`), and web interface (`mitmweb`) for intercepting, modifying, and replaying target traffic. | `sudo apt install -y mitmproxy` or `pipx install mitmproxy` |

---

## 2. Defensive Stack (Detection, Forensics & Telemetry)

These defensive components provide host, network, and code-level visibility to measure how offensive operations register against enterprise security controls.

| Tool | Category | License | Core Defensive Utility | Pop!_OS Installation |
| :--- | :--- | :--- | :--- | :--- |
| **Suricata** | Network IDS / IPS / NSM | GPLv2 | Multi-threaded packet inspection engine that flags rule signatures, protocol anomalies, and active exploitation attempts on the wire in real time. | `sudo add-apt-repository ppa:oisf/suricata-stable && sudo apt update && sudo apt install suricata jq -y` |
| **Zeek** | Network Behavioral Telemetry | BSD-3-Clause | Passive network security monitoring framework translating raw packet captures into structured, transaction-level audit logs (`conn.log`, `http.log`, `dns.log`). | `sudo apt install -y zeek` |
| **Wazuh** | Host XDR / SIEM | GPLv2 / Apache 2.0 | Endpoint visibility agent monitoring file integrity (FIM), system call logging, configuration compliance, and rootkit/anomalous process hooks. | Single-node Docker deployment or APT via `packages.wazuh.com` |
| **Semgrep OSS** | Static AppSec Testing (SAST) | LGPL-2.1 | Fast AST-based static code analyzer to search codebases for insecure patterns, unsafe deserialization, and missing authorization boundaries. | `python3 -m pip install semgrep` |
| **Falco** | Cloud-Native Runtime Security | Apache 2.0 | Kernel-level behavioral monitor powered by eBPF probes, detecting unexpected system calls, namespace escapes, and privilege escalations in real time. | `curl -fsSL https://falco.org/repo/falcosecurity-packages.asc \| sudo gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg` |

---

## 3. Operational Gaps Across the 10-Tool Stack

While individual tools excel at their designated operational scope, chaining them as an ad-hoc collection introduces critical functional blind spots:

```
[ Amass / httpx ] ---> (Flat Text / JSON Lines) ---> [ ffuf / Nuclei ]
                                                             |
                                                   (Network Boundary)
                                                             |
[ Suricata / Zeek ] <------- (Raw Wire Capture) -------------+
         |
    (Isolated)
         v
[ Wazuh / Falco ]
```

1. **Pipeline Disconnect & State Fragmentation:** CLI tools emit separate, unstructured or semi-structured output files (`.txt`, JSON lines). There is no central schema tracking an asset's lifecycle from initial discovery (`amass`) to live verification (`httpx`), endpoint fuzzing (`ffuf`), and vulnerability triage (`nuclei`).
2. **Open-Loop Fuzzing Without Feedback:** Fuzzers like `ffuf` rely entirely on static status codes, line counts, and regular expressions. They cannot observe how defensive telemetry (`Suricata`, `Wazuh`) reacts, nor do they adapt mutation strategies dynamically when a target silently drops TCP packets or returns WAF challenges.
3. **Telemetry & Dashboard Resource Overhead:** Correlating active research traffic with SIEM and IDS alerts typically requires running resource-intensive ELK stacks or heavy Electron desktop proxies that degrade local performance.
4. **Strict Layer-7 RFC Enforcement:** Standard HTTP libraries (used by `httpx` and `mitmproxy`) enforce strict HTTP compliance. They normalize malformed headers and delimiters, preventing researchers from identifying reverse-proxy parser differentials, byte-level request smuggling, and HTTP/2 framing desyncs.

---

## 4. Custom Tooling Engineering Blueprint

To resolve these operational gaps, the following modular architecture leverages **Rust, Go, Python, HTMX, and POSIX Shell**:

```
+-------------------------------------------------------------------------+
|                  Local Research Cockpit (Go + HTMX)                     |
|         - Real-time DOM patching via Server-Sent Events (SSE)           |
|         - In-memory event stream & target status view                   |
+------------------------------------+------------------------------------+
                                     |
+------------------------------------+------------------------------------+
|                  Core Orchestrator & State DB (Go)                      |
|         - Asynchronous worker pool & pipeline manager                   |
|         - Embedded SQLite / DuckDB tracking targets and scan state      |
+-------------------+---------------------------------+-------------------+
                    |                                 |
+-------------------+---------------+   +-------------+-------------------+
|    Low-Level Mutator (Rust)       |   | Contextual Analyzer (Python)    |
| - Custom TCP/TLS byte framing     |   | - AST response differential     |
| - Non-RFC HTTP/1.1 & H2 desyncs   |   | - Context-aware parameter logic |
+-------------------+---------------+   +-------------+-------------------+
                    |                                 |
+-------------------+---------------------------------+-------------------+
|               Ephemeral Sandboxing Harness (POSIX Shell)                |
|      - Spins up vulnerable targets alongside Zeek & Suricata            |
|      - Captures automated pcap & correlates alerts vs. scan output      |
+-------------------------------------------------------------------------+
```

### Module 1: Low-Level Protocol & Frame Mutator
* **Language:** **Rust**
* **Key Crates:** `tokio`, `rustls` (or `native-tls`), `bytes`, `clap`
* **Target Gap:** Layer-7 RFC enforcement and parser desync limitations.
* **Architecture:**
  * Uses raw `tokio::net::TcpStream` wrapped in a custom TLS handshake layer.
  * Implements byte-buffer builders allowing intentional RFC mutations: irregular whitespace padding, duplicate `Content-Length` headers, malformed chunked transfer encodings, and out-of-order HTTP/2 frame delivery (`HEADERS` following trailing `DATA` frames).
  * Outputs structured JSON metadata detailing exact raw bytes transmitted and received.

### Module 2: Streaming Recon Orchestrator & Asset Graph
* **Language:** **Go**
* **Key Libraries:** `mattn/go-sqlite3` (or `duckdb/duckdb`), `gorilla/websocket`, `spf13/cobra`
* **Target Gap:** State fragmentation and uncoordinated CLI pipelines.
* **Architecture:**
  * Asynchronous worker pool using native Go channels (`chan Job`) to coordinate external CLI tools.
  * Ingests `stdin` streams from `amass` and `httpx`, deduplicating assets in an embedded SQLite database:
    ```sql
    CREATE TABLE targets (
        id INTEGER PRIMARY KEY,
        domain TEXT NOT NULL UNIQUE,
        ip TEXT,
        port INTEGER,
        tech_stack JSON,
        status_code INTEGER,
        last_scanned TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```
  * Automatically dispatches secondary jobs based on state transitions (e.g., triggering endpoint fuzzing upon receiving an `HTTP 200` response).

### Module 3: Contextual Response & AST Analyzer
* **Language:** **Python**
* **Key Libraries:** `tree-sitter`, `beautifulsoup4`, `mitmproxy` API, `pydantic`
* **Target Gap:** Open-loop fuzzing and static parameter reflection.
* **Architecture:**
  * Operates as an inline `mitmproxy` addon (`addon.py`) or standalone downstream response parser.
  * Ingests HTTP responses and parses them into concrete Abstract Syntax Trees (HTML, JavaScript, JSON).
  * Determines the exact reflection context of parameters (e.g., inside an unquoted attribute, script string, or SQL query) and computes boundary-break requirements rather than relying on generic fuzz lists.

### Module 4: Localhost GUI Cockpit
* **Language:** **Go + HTMX** (or Python FastAPI + HTMX)
* **Target Gap:** High resource footprint of traditional monitoring dashboards and Electron wrappers.
* **Architecture:**
  * Single Go binary compiling embedded HTML templates via standard `html/template` and `embed`.
  * Front-end utilizes HTMX with `hx-sse` (Server-Sent Events) to stream live discovery logs and vulnerability alerts directly into browser tables with minimal memory overhead:
    ```html
    <div hx-ext="sse" sse-connect="/api/stream/events" sse-swap="message">
        <table id="recon-feed">
            <!-- Dynamically populated table rows -->
        </table>
    </div>
    ```
  * No external JavaScript bundlers, Node.js runtimes, or client-side build steps required.

### Module 5: Ephemeral Sandboxing Harness
* **Language:** **POSIX Shell (`sh` / `bash`)**
* **Dependencies:** `docker`, `docker-compose`, `jq`, `tshark`
* **Target Gap:** Reproducibility and evasion validation.
* **Architecture:**
  * Spins up containerized test targets alongside local Suricata and Zeek instances on an isolated Docker bridge network.
  * Runs offensive test modules, records raw `.pcap` files, parses `eve.json` (Suricata) and `notice.log` (Zeek), and outputs a differential detection report:
    ```text
    Executed Payloads:    154
    Suricata Detections:  82
    Zeek Anomalies:       140
    Undetected Vectors:   14  (Flagged for parser desync review)
    ```

---

## 5. Pop!_OS Development Environment Bootstrap

Execute the script below to initialize your system packages, runtimes, and project directories:

```bash
#!/usr/bin/env bash
set -euo pipefail

# 1. Update Core System & Build Essentials
sudo apt update && sudo apt upgrade -y
sudo apt install -y \
    build-essential \
    curl \
    git \
    pkg-config \
    libssl-dev \
    libpcap-dev \
    sqlite3 \
    libsqlite3-dev \
    jq \
    tshark

# 2. Install Rust Toolchain
if ! command -v rustup &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# 3. Install Go Toolchain
sudo apt install -y golang-go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# 4. Install Python Tooling & Package Isolation
sudo apt install -y python3 python3-pip python3-venv pipx
pipx ensurepath

# 5. Initialize Workspace Directories
mkdir -p ~/cybersec-workspace/{offensive,defensive,custom-tools,pcaps}
cd ~/cybersec-workspace/custom-tools

echo "[✓] Environment initialized. Workspace ready at ~/cybersec-workspace."
```

---

## 6. Development Phasing

1. **Phase 1 (Data Layer & Orchestration):** Build the Go SQLite target pipeline (`Module 2`) to reliably ingest and deduplicate data from `amass` and `httpx`.
2. **Phase 2 (Telemetry UI):** Add the Go embedded HTTP server and HTMX frontend (`Module 4`) to stream target states via Server-Sent Events.
3. **Phase 3 (Protocol Mutation):** Implement the Rust low-level raw socket mutator (`Module 1`) to probe for parser differentials and HTTP desync behavior.
4. **Phase 4 (Contextual Analysis):** Integrate the Python AST analyzer (`Module 3`) with `mitmproxy` to dynamically identify injection boundaries.
5. **Phase 5 (Verification Harness):** Tie the components together inside the POSIX shell testing framework (`Module 5`) to benchmark offensive tools against defensive telemetry.