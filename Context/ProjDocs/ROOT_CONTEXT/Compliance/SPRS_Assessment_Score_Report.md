# CYBERNEST HOLDINGS LLC - NIST SP 800-171 SELF-ASSESSMENT SCORE WORKSHEET
## DoD Supplier Performance Risk System (SPRS) Assessment Methodology v1.2.1 (Pre-Submission Worksheet)

* **Document ID**: `CN-SPRS-2026-1029`
* **Legal Business Name**: CyberNest Holdings LLC (a Pennsylvania Manager-Managed Operating LLC)
* **Responsible Internal Department**: CyberNest Labs (Internal R&D and Security Department of CyberNest Holdings LLC)
* **SAM.gov UEI / DLA CAGE Status**: `NOT YET ASSIGNED (Pending Initial SAM.gov Registration)`
* **PIEE / SPRS Portal Submission Status**: `PRE-SUBMISSION WORKSHEET (Ready for PIEE Upload Once UEI & CAGE Are Assigned)`
* **Assessment Type**: Internal Engineering Basic Self-Assessment (NIST SP 800-171A)
* **Assessment Date**: October 29, 2026
* **Assessed By**: William R. M. (Auxk0rd), President and Chief Architect
* **Reviewed By**: James D. J. (JD), Chief Executive Officer
* **Computed Technical Self-Assessment Score**: **110 / 110**

---

## 1. SPRS Self-Assessment Summary & Registration Status

> [!NOTE]
> **SPRS Filing Prerequisite**: Per DoD Assessment Methodology v1.2.1 (DFARS 252.204-7019 / 252.204-7020), uploading a Basic Self-Assessment score to the DoD Supplier Performance Risk System (SPRS) requires an active SAM.gov **Unique Entity ID (UEI)** and **DLA CAGE Code**. Because CyberNest Holdings LLC has not yet completed SAM.gov registration (tracked under `POAM-2026-007` and `POAM-2026-008`), this document serves as the official internal engineering self-assessment worksheet ready for immediate upload upon UEI/CAGE issuance.

| Metric | Value / Status |
| :--- | :--- |
| **Legal Entity Name** | **CyberNest Holdings LLC** (Commonwealth of Pennsylvania LLC) |
| **SAM.gov UEI / DLA CAGE** | `NOT YET ASSIGNED` (`Pending Registration`) |
| **SPRS Portal Upload Status** | `PENDING UEI & CAGE ISSUANCE` |
| **Base Maximum Possible Score** | `110` |
| **Total Controls Evaluated (NIST SP 800-171 Rev. 2)** | `110 / 110` |
| **Technical Controls Satisfied in Codebase (`PASS`)** | `110` |
| **5-Point Weighted Deductions** | `0` |
| **3-Point Weighted Deductions** | `0` |
| **1-Point Weighted Deductions** | `0` |
| **Computed Internal Self-Assessment Score** | **`110`** |
| **System Security Plan (SSP) Reference** | `CN-SSP-2026-1029` |
| **POA&M Reference** | `CN-POAM-2026-1029` |

---

## 2. Family-by-Family Control Verification Breakdown

| Control Family | ID Prefix | Total Controls | Satisfied | Point Deduction | Primary RPGS Technical Evidence |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **Access Control** | `3.1.x` (`AC`) | 22 | 22 | `0` | `127.0.0.1` loopback binding, `verifyOrigin` CWE-346 firewall, `nestCommGater` P2P stream ACLs, IEEE 802.11w PMF + Client Isolation. |
| **Awareness & Training** | `3.2.x` (`AT`) | 3 | 3 | `0` | Mandatory `Handoff.md` developer security manuals, `Off_Def_BackEnd_Framework.md` offensive/defensive lab drills. |
| **Audit & Accountability** | `3.3.x` (`AU`) | 9 | 9 | `0` | `KwikLogPro` `kwikparse` SHA-256 log deduplication, SQLite WAL audit tables, Ed25519-signed STIG & SBOM audit records. |
| **Configuration Management** | `3.4.x` (`CM`) | 9 | 9 | `0` | `NestPatch` DISA STIG config synthesizer, 120s dead-man's switch rollback timer, pinned `Cargo.lock` / `go.sum` / `SBOM.cyclonedx.json`. |
| **Identification & Authentication** | `3.5.x` (`IA`) | 11 | 11 | `0` | Dynamic Ed25519 keypairs, OS Keyring master key integration, Shannon Entropy $H(X)$ secret scanners, 128-bit session CSRF tokens. |
| **Incident Response** | `3.6.x` (`IR`) | 3 | 3 | `0` | STIX 2.1 & TAXII 2.1 automated threat intelligence bundle exporters across `BlackRoute-Web`, `KwikLogPro`, `NestPatch`, `NestComm`, `NestLink`, `NestSBOM`. |
| **Maintenance** | `3.7.x` (`MA`) | 6 | 6 | `0` | `KwikLogPro` deterministic remediation prescriptions (`POP_*`, `WIN_*`, `HW_*`) and out-of-band RS-232 serial recovery (`NestPatch`). |
| **Media Protection** | `3.8.x` (`MP`) | 9 | 9 | `0` | Authenticated AES-256-GCM encryption for local SQLite WAL databases and `.enc` enclaves, `0600` file / `0700` dir permissions, `umask 077`. |
| **Personnel Security** | `3.9.x` (`PS`) | 2 | 2 | `0` | 100% US Citizen executive management and subcontractor verification (`FOCI_Attestation_Certificate.md` & `Field Engineering Subcontractor Agreement`). |
| **Physical Protection** | `3.10.x` (`PE`) | 6 | 6 | `0` | Air-gapped Pop!_OS LUKS2 workstation enclave, `/dev/ttyUSB*` hardware device node validation, and time-stamped "before"/"after" dispatch photo verification. |
| **Risk Assessment** | `3.11.x` (`RA`) | 3 | 3 | `0` | `BlackRoute-Web` DAST & AST vulnerability scanner, `NestSBOM` CISA supply-chain risk analyzer, `KwikLogPro` OLS degradation slopes. |
| **Security Assessment** | `3.12.x` (`CA`) | 4 | 4 | `0` | Automated unit/E2E security test suites in every codebase plus `sandbox_harness.sh` Suricata/Zeek verification. |
| **System & Comms Protection** | `3.13.x` (`SC`) | 16 | 16 | `0` | `GOFIPS=1` / FIPS 140-3 KAT validation, Noise Protocol P2P streams, CWE-400 64KB request caps, DISA STIG VLAN 999 blackholing. |
| **System & Info Integrity** | `3.14.x` (`SI`) | 7 | 7 | `0` | CWE-22 path sanitization (`sanitize_relative_path`, `safe_resolve_under`), CWE-377 symlink guards, CWE-1333 zero-panic Rust engines. |
| **TOTAL** | **14 Families** | **110** | **110** | **`0`** | **COMPUTED SELF-ASSESSMENT SCORE: `110` (PENDING SPRS UPLOAD)** |
