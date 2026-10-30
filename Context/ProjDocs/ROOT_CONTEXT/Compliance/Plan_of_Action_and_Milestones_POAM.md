# CYBERNEST HOLDINGS LLC - PLAN OF ACTION & MILESTONES (POA&M)
## NIST SP 800-171 Rev. 2 / CMMC 2.0 Level 2 & Federal Registration Milestones

* **Document ID**: `CN-POAM-2026-1029`
* **Legal Entity**: CyberNest Holdings LLC (a Pennsylvania Manager-Managed Operating LLC)
* **Responsible Internal Department**: CyberNest Labs (Internal Department of CyberNest Holdings LLC)
* **Technical Point of Contact**: William R. M. (Auxk0rd), President and Chief Architect
* **Executive Sponsor**: James D. J. (D), Chief Executive Officer
* **Last Updated**: October 29, 2026
* **Technical Self-Assessment Score**: `110 / 110 Controls Enforced in Codebase` (*Official PIEE/SPRS Upload Pending SAM.gov UEI & DLA CAGE Assignment*)

---

## 1. POA&M Executive Summary

In accordance with **NIST SP 800-171 Rev. 2 Control 3.12.2 (`CA.L2-3.12.2`)** and the *CyberNest Holdings LLC Master Corporate Charter & Treasury Policy (v1.0.2)*, CyberNest Holdings LLC maintains this formal Plan of Action & Milestones (POA&M) ledger to track:
1. Completed codebase architectural hardening tasks across all six CyberNest Labs applications;
2. Pending federal entity registration milestones (**SAM.gov UEI assignment**, **DLA CAGE Code assignment**, and **DoD PIEE/SPRS score submission**); and
3. Ongoing cryptographic and hardware lifecycle maintenance across the Pop!_OS engineering enclave and field deployment kits.

---

## 2. Active & Completed POA&M Ledger

| POA&M ID | NIST / Federal Reference | Milestone / Enhancement Description | Impacted Systems / Entity Scope | Target / Completion Date | Current Status |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **POAM-2026-001** | `SC.L2-3.13.11` | Enforce FIPS 140-3 conditional compilation (`GOFIPS=1 GODEBUG=fips140=on` & Rust FIPS KAT self-tests) across all compiled Go and Rust engines. | All 6 Codebases (`BlackRoute-Web`, `KwikLogPro`, `NestComm`, `NestLink`, `NestPatch`, `NestSBOM`) | 2026-10-28 | `[COMPLETED // CLOSED]` |
| **POAM-2026-002** | `MP.L2-3.8.1` / `SC.L2-3.13.16` | Upgrade all local SQLite WAL databases and state enclaves to enforce authenticated AES-256-GCM encryption and `0600` file permissions. | All 6 Codebases | 2026-10-28 | `[COMPLETED // CLOSED]` |
| **POAM-2026-003** | `IA.L2-3.5.2` / `IA.L2-3.5.10` | Replace all static identifiers with dynamic Ed25519 cryptographic keypairs backed by OS Keyring and AES-256-GCM encrypted `identity.enc`. | All 6 Codebases | 2026-10-28 | `[COMPLETED // CLOSED]` |
| **POAM-2026-004** | `SI.L2-3.14.1` / `EO-14028` | Deploy automated CycloneDX 1.5 & SPDX 2.3 JSON SBOM generation in every build script and launch the `NestSBOM` CISA Ingestion & Visualization App. | All 6 Codebases + `NestSBOM` | 2026-10-28 | `[COMPLETED // CLOSED]` |
| **POAM-2026-005** | `SI.L2-3.14.6` / `CWE-1333` | Eliminate all `.unwrap()` and `.expect()` calls across Rust engines and enforce CWE-377, CWE-114, CWE-22, CWE-346, CWE-400, and CWE-1333 mitigations. | All 6 Codebases | 2026-10-28 | `[COMPLETED // CLOSED]` |
| **POAM-2026-006** | `SC.L2-3.13.1` / `AC.L2-3.1.16` | Enforce IEEE 802.3 & IEEE 802.11w Protected Management Frames (PMF) sensing validation and 1-click DISA STIG compliance certificate export. | All 6 Codebases | 2026-10-28 | `[COMPLETED // CLOSED]` |
| **POAM-2026-007** | `FAR 52.204-7` / `SAM.gov` | **Initial SAM.gov Entity Registration & UEI Assignment**: Submit Pennsylvania LLC formation documents and corporate treasury EFT details to SAM.gov to obtain an official 12-character Unique Entity ID (UEI). | CyberNest Holdings LLC (Corporate Entity) | Q4 2026 / Q1 2027 | `[OPEN // PRE-REGISTRATION]` |
| **POAM-2026-008** | `DFARS 252.204-7019` / `DLA CAGE` & `SPRS` | **DLA CAGE Code Assignment & DoD SPRS Score Upload**: Upon SAM.gov UEI validation and CAGE assignment, register in DoD PIEE and submit the completed NIST SP 800-171 Basic Self-Assessment worksheet (`CN-SPRS-2026-1029`). | CyberNest Holdings LLC (Corporate Entity) | Q1 2027 (Upon UEI/CAGE Issuance) | `[OPEN // PENDING UEI & CAGE]` |
| **POAM-2026-009** | `PE.L2-3.10.1` / `MA.L2-3.7.5` | Quarterly offline air-gapped hardware HSM / YubiKey FIPS Series 5 rotation for code-signing root certificates. | Corporate Build Enclave | 2027-01-15 | `[SCHEDULED // ON_TRACK]` |
| **POAM-2026-010** | `CA.L2-3.12.1` | Semi-annual CMMC Certified Third-Party Assessment Organization (C3PAO) readiness audit and Suricata/Zeek rule baseline refresh. | Corporate Build Enclave | 2027-04-01 | `[SCHEDULED // ON_TRACK]` |

---

## 3. Continuous Verification Protocol

Every code commit or build invocation via `./launcher.sh build` or `./dev.sh build`:
1. Executes static CWE mitigation assertions (verifying zero `fuser -k`, zero `.unwrap()`/`.expect()` in Rust, `umask 077`, and symlink-hardened logging).
2. Compiles Go binaries under `GOFIPS=1 GODEBUG=fips140=on` and verifies FIPS 140-3 Known-Answer Tests (KAT).
3. Regenerates `SBOM.cyclonedx.json`, `SBOM.spdx.json`, and `SBOM.md` with fresh SHA-256 binary and source digests.
