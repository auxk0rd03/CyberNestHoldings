# CYBERNEST HOLDINGS LLC - SYSTEM SECURITY PLAN (SSP)
## NIST SP 800-171 Rev. 2 & CMMC 2.0 Level 1 / Level 2 Operational Enclave

* **Document ID**: `CN-SSP-2026-1029`
* **Legal Entity**: CyberNest Holdings LLC (a Pennsylvania Manager-Managed Operating Limited Liability Company)
* **Responsible Internal Department**: CyberNest Labs (Internal R&D and Security Department of CyberNest Holdings LLC; not a separate legal entity)
* **Federal Registration Status**: `PRE-REGISTRATION (SAM.gov UEI & DLA CAGE Not Yet Assigned)`
* **Executive Management & Authority** (per *Master Corporate Charter & Treasury Policy v1.0.2* and *Operating Agreement v1.0.2*):
  * **William Ray Moore (William R. Moore / Auxk0rd)** - President and Chief Architect (Authority over R&D, Technical Operations, Systems Architecture, Security, and Treasury Risk Controls)
  * **James Dwayne Jarrell (James D. Jarrell / JD)** - Chief Executive Officer (Authority over Sales, Public Outreach, Growth Strategy, Partnerships, and Client/Contract Acquisition)
* **Technical Compliance Frameworks Enforced**:
  * **CMMC 2.0 Level 1**: FAR 52.204-21 (17 Basic Safeguarding Controls)
  * **CMMC 2.0 Level 2**: NIST SP 800-171 Rev. 2 (110 Security Requirements for CUI)
  * **Cryptographic Standard**: FIPS 140-3 (`GOFIPS=1` / AWS-LC-FIPS / AES-256-GCM / Ed25519)
  * **Supply Chain Mandate**: Executive Order 14028 & CISA Minimum Elements for SBOM (CycloneDX 1.5 & SPDX 2.3 JSON)
* **Date of Issuance**: October 29, 2026

---

## 1. System Identification, Corporate Governance & Operational Boundary

### 1.1 Corporate Ownership & Authorization Boundary
Pursuant to Article I and Article IX of the *Operating Agreement of CyberNest Holdings LLC (v1.0.2)*, all intellectual property, software, security technologies, and operating assets within this enclave are the **exclusive property of CyberNest Holdings LLC**. Internal departments (**CyberNest Labs**, **CyberNest Farms**, and **CyberNest ADMD**) act as internal economic participants for accounting purposes only and are not separate legal entities.

The **CyberNest Air-Gapped Polyglot Security Enclave** encompasses all workstation build environments, local storage enclaves (`~/.cache/<app>`), and the six core **RPGS (Rust, Python, Go, Shell) + HTMX / Textual** software applications developed by the CyberNest Labs department for CyberNest Holdings LLC:

| Application ID | Designation | Operational Role | Runtime Stack | Loopback Binding |
| :--- | :--- | :--- | :--- | :--- |
| **CN-APP-01** | **BlackRoute-Web** | Offensive/Defensive Web DAST, Protocol Mutator, AST Context Analyzer & STIX/TAXII Exporter | Rust + Go + Python + Shell + HTMX (`synth-ledger.css`) | `127.0.0.1:8000` |
| **CN-APP-02** | **KwikLogPro** | Air-Gapped System Health Auditor, NVMe SMART & OLS Regression Engine | Go + Rust + Python + Shell + HTMX (`synth-ledger.css`) | `127.0.0.1:8484` |
| **CN-APP-03** | **NestComm** | Encrypted P2P Synchronous & Store-and-Forward Messaging Node | Go (`libp2p`/Noise) + Rust Daemon + Shell + HTMX | `127.0.0.1:8080` |
| **CN-APP-04** | **NestLink** | Cryptographic P2P SSH Multiplexing Tunnel & Hole-Punching Proxy | Go (`libp2p`/DHT) + Rust Daemon + Shell + HTMX | `127.0.0.1:8080` (`:2222` SSH) |
| **CN-APP-05** | **NestPatch** | Single-IP Automated Military-Grade DISA STIG VLAN Provisioner | Python (Textual TUI) + Rust AST Auditor + Go Dispatcher + Shell | Pure Terminal (`127.0.0.1` IPC) |
| **CN-APP-06** | **NestSBOM** | CISA-Compliant SBOM Ingestion, CycloneDX/SPDX Synthesizer & Supply-Chain Auditor | Rust + Go + Python + Shell + HTMX (`synth-ledger.css`) | `127.0.0.1:8090` |

### 1.2 Hardware & Host Operating System Inventory
* **Primary Engineering & Field OS**: Pop!_OS 22.04 / 24.04 LTS (Debian/Ubuntu LTS Linux Kernel 6.8+ with LUKS2 AES-XTS-Plain64 512-bit full-disk encryption).
* **Secondary Field Support OS**: Microsoft Windows 10 / 11 Enterprise with BitLocker XTS-AES-256 hardware-backed TPM 2.0 protection.
* **Network Interface Controllers**:
  * Wired Ethernet (`IEEE 802.3`): Local loopback (`lo`) and physical RJ-45 / SFP+ management interfaces with 802.1Q VLAN tagging.
  * Wireless LAN (`IEEE 802.11`): Enterprise Wi-Fi adapters enforcing mandatory **IEEE 802.11w Protected Management Frames (PMF)** (`ieee80211w=2`) and Layer 2 Client Isolation.

---

## 2. CMMC Level 1 (FAR 52.204-21 - 17 Controls) Verification Matrix

| FAR Reference | NIST 800-171 Mapping | Control Description | CyberNest RPGS Implementation | Status |
| :--- | :--- | :--- | :--- | :--- |
| **b.1.i** | `AC.L1-3.1.1` | Limit system access to authorized users | OS user-scoped execution (`umask 077`), dynamic session CSRF/Auth tokens (`crypto/rand`), and Ed25519 node identity verification. | `[IMPLEMENTED]` |
| **b.1.ii** | `AC.L1-3.1.2` | Limit system access to authorized transactions | Strict HTTP method & route whitelisting, `verifyOrigin` Host/Origin firewall (`127.0.0.1` / `localhost`), and `nestCommGater` stream gating. | `[IMPLEMENTED]` |
| **b.1.iii** | `AC.L1-3.1.20` | Verify and control external connections | 100% air-gapped runtime capability; zero cloud SaaS dependencies; outbound connections restricted to operator-specified targets. | `[IMPLEMENTED]` |
| **b.1.iv** | `AC.L1-3.1.22` | Control information posted on public systems | All web dashboards bind strictly to `127.0.0.1` loopback; zero public listener exposure. | `[IMPLEMENTED]` |
| **b.1.v** | `IA.L1-3.5.1` | Identify system users, processes, and devices | Dynamic Ed25519 public-key peer IDs (`12D3KooW...`), explicit POSIX child PID tracking (`APP_PID=$!`), and device SHA-256 fingerprinting. | `[IMPLEMENTED]` |
| **b.1.vi** | `IA.L1-3.5.2` | Authenticate users, processes, and devices | Ed25519 cryptographic signatures, Noise Protocol handshakes, OS Keyring master key retrieval, and per-session 128-bit tokens. | `[IMPLEMENTED]` |
| **b.1.vii** | `MP.L1-3.8.3` | Sanitize or destroy media before disposal | Zero-Footprint temporary directory teardown (`shutil.rmtree` on `0700` harvest sandboxes) and encrypted SQLite WAL enclaves. | `[IMPLEMENTED]` |
| **b.1.viii** | `PE.L1-3.10.1` | Limit physical access to systems | Controlled CyberNest Holdings LLC engineering workstations and time-stamped visual site verification for field dispatches. | `[IMPLEMENTED]` |
| **b.1.ix-x** | `PE.L1-3.10.3-5` | Escort visitors, audit logs, control access devices | Physical access ledgers, 3-hour mandatory field dispatch archival ledger, and UART/RS-232 device node validation (`/dev/ttyUSB*` allowlist). | `[IMPLEMENTED]` |
| **b.1.xi** | `SC.L1-3.13.1` | Monitor, control, and protect communications | Suricata IDS + Zeek NSM telemetry harness (`sandbox_harness.sh`), SSRF private/metadata IP blocklists, and Host header firewalls. | `[IMPLEMENTED]` |
| **b.1.xii** | `SC.L1-3.13.5` | Implement subnetworks for publicly accessible components | Automated DISA STIG VLAN segmentation (`NestPatch`), Blackhole VLAN `999` isolation, and Docker bridge sandboxing. | `[IMPLEMENTED]` |
| **b.1.xiii** | `SI.L1-3.14.1` | Identify, report, and correct system flaws | Automated KwikLogPro OLS health diagnostics, Rust `patch_auditor` STIG checks, and NestSBOM vulnerability auditing. | `[IMPLEMENTED]` |
| **b.1.xiv-xv** | `SI.L1-3.14.2-5` | Malicious code protection & periodic scans | Static compilation without runtime eval, CWE-22/377/1333 guards, and Semgrep/Falco/Wazuh host defensive stack. | `[IMPLEMENTED]` |

---

## 3. CMMC Level 2 (NIST SP 800-171 Rev. 2 - 110 Controls) Domain Architecture

### 3.1 Access Control (`3.1.1` - `3.1.22`)
* **Loopback Enclave Binding (`AC.L2-3.1.1`)**: Every HTTP/HTMX cockpit binds exclusively to `127.0.0.1`.
* **DNS Rebinding & Origin Firewall (`AC.L2-3.1.2`, CWE-346)**: Every Go and Python HTTP server enforces strict `Host` (`127.0.0.1` / `localhost`) and `Origin` header validation prior to request processing.
* **Wireless Access Restrictions (`AC.L2-3.1.16`, `3.1.17`)**: `NestPatch` and all suite medium sensors validate `IEEE 802.11w` Protected Management Frames (`ieee80211w='2'`), WPA3-SAE authentication, and Layer 2 Wireless Client Isolation (`isolate='1'`).

### 3.2 Identification & Authentication (`3.5.1` - `3.5.11`)
* **Dynamic Ed25519 Cryptographic Identities (`IA.L2-3.5.2`, `3.5.10`)**: All static credentials (`0xABCD1234`, hardcoded keys) are banned. Every application generates dynamic Ed25519 keypairs using OS CSPRNG (`crypto/rand` / `secrets`) and persists private keys inside AES-256-GCM encrypted files (`identity.enc`, `0600` permissions) backed by native OS Keyring (`zalando/go-keyring` / DBus Secret Service).
* **Secret Leak Prevention (`IA.L2-3.5.10`)**: Rust and Python Shannon Entropy $H(X) = -\sum P(x) \log_2 P(x)$ scanners automatically detect and redact exposed API keys, Type-7 passwords, and SNMP community strings.

### 3.3 Media Protection & Cryptographic Storage (`3.8.1` - `3.8.9`)
* **AES-256-GCM Local Database Encryption (`MP.L2-3.8.1`, `SC.L2-3.13.16`)**: All local persistent state (SQLite WAL databases `.db`, `.enc` queues, audit snapshots) enforces authenticated AES-256-GCM encryption with 96-bit nonces and 128-bit authentication tags.
* **Strict POSIX File Permissions (`MP.L2-3.8.2`)**: Directories are created with `0700` permissions (`mkdir -p -m 700`), files with `0600` (`chmod 600`), and processes run under `umask 077`.

### 3.4 System & Communications Protection (`3.13.1` - `3.13.16`)
* **FIPS 140-3 Cryptographic Validation (`SC.L2-3.13.11`)**:
  * **Go Engines**: Compiled with `GOFIPS=1 GODEBUG=fips140=on` and verified at startup via FIPS 140-3 Known-Answer Tests (KAT) for AES-256-GCM and SHA-256.
  * **Rust Engines**: Execute deterministic FIPS 140-3 SHA-256 / entropy Known-Answer Tests (KAT) prior to processing inputs and support `AWS-LC-FIPS` / OpenSSL FIPS feature bindings.
* **DISA STIG Port Security & Transactional Dead-Man's Switch (`SC.L2-3.13.6`, `3.13.8`)**:
  * `NestPatch`, `NestComm`, and `NestLink` enforce a **120-second transactional dead-man's switch rollback timer** on network/tunnel provisioning mutations to prevent operator lockout.
  * Automated DISA STIG Layer 2/Layer 3 controls enforce DHCP Snooping, Dynamic ARP Inspection (DAI), BPDU Guard, `switchport nonegotiate`, and Blackhole VLAN `999` isolation.

---

## 4. Programmatic CWE Mitigation Standard (Enforced Across All 6 Codebases)

| CWE ID | Vulnerability Class | Mandatory RPGS Mitigation Architecture |
| :--- | :--- | :--- |
| **CWE-377** | Insecure Temporary File / Symlink Hijacking | User-scoped logging (`~/.cache/<app>/`), explicit `[ -L "$LOG_FILE" ] && rm -f "$LOG_FILE"` assertions, `umask 077`, `0700` directory and `0600` file permissions. |
| **CWE-114** | Process Control / Destructive Port Killing | Explicit child PID capture (`APP_PID=$!`); zero `fuser -k` or `killall` usage; targeted `SIGTERM` -> `SIGKILL` escalation in POSIX `EXIT INT TERM` traps. |
| **CWE-22** | Path Traversal / Zip-Slip | Multi-stage `sanitize_relative_path` & `safe_resolve_under` verifying `resolved.is_relative_to(base_dir)` and rejecting `..`, null bytes, and symlinks. |
| **CWE-346** | Origin Validation Error / DNS Rebinding | Security middleware validating `Host` against `127.0.0.1` / `localhost` and rejecting untrusted `Origin` headers with `HTTP 403 Forbidden`. |
| **CWE-400** | Uncontrolled Resource Consumption | Request body capping (`http.MaxBytesReader` at 64KB in Go; 64KB body cap middleware in Python), explicit socket timeouts, and bounded worker pools. |
| **CWE-1333** | Inefficient Regular Expression Complexity (ReDoS) & Panics | Linear-time $O(n)$ Thompson NFA regex engines / single-pass AST parsers and strict `Result<T, E>` error handling in Rust with **zero** `.unwrap()` or `.expect()` calls. |

---

## 5. Attestation & Sign-Off

We hereby certify that the security controls, cryptographic implementations, and supply-chain SBOM mechanisms documented in this System Security Plan (SSP) are actively enforced across all CyberNest Holdings LLC repositories.

* **William Ray Moore (Auxk0rd)** - *President and Chief Architect, CyberNest Holdings LLC*
* **James Dwayne Jarrell (JD)** - *Chief Executive Officer, CyberNest Holdings LLC*
