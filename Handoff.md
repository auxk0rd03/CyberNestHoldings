# CyberNest Holdings LLC // Static Website Handoff Manual

* **Company:** CyberNest Holdings LLC (Pennsylvania Manager-Managed Operating LLC)
* **Departments:** CyberNest Labs, CyberNest Farms, CyberNest ADMD
* **Leadership:** William R. M. (Auxk0rd) — President & Chief Architect | James D. J. (JD) — CEO
* **Official Contact:** `cybernestllc@gmail.com`
* **Theme:** `Context/ProjDocs/ROOT_CONTEXT/synth-ledger.css` (`SYS.01 // NOCTURNAL SYNTH-LEDGER`)

---

## 1. Site Overview & Directory Structure

This repository is a pure static HTML/CSS website with an early-internet Webcore layout styled using `synth-ledger.css`. It requires zero build tools, bundlers, or backend servers.

```text
WebPageStatic/
├── .nojekyll                                           # Tells GitHub Pages to serve all folders/files directly
├── _headers                                            # Cloudflare Pages / Edge CDN Security Response Headers
├── security-headers.conf                               # Nginx reverse proxy security header configuration
├── worker.js                                           # Cloudflare Worker edge proxy script for BlackRoute-Web 0/100
├── anti-clickjack.js                                   # Frame-busting clickjacking defense script
├── Handoff.md                                          # Deployment and maintenance instructions
├── index.html                                          # Main Home page (GitHub Pages root entrypoint)
├── synth-ledger-ext.css                                # Minimal Webcore layout rules extending synth-ledger.css
├── update_archive_index.sh                             # Shell script to sync .zip files & recompute SHA256SUMS.txt
├── LandingPg/
│   └── index.html                                      # Mirror Home page for /LandingPg/ path
├── AboutUs/
│   └── index.html                                      # Company & All-Departments About Us page
├── ContactUs/
│   └── index.html                                      # Contact page (cybernestllc@gmail.com + Google Form)
├── Depts/
│   ├── index.html                                      # Departments overview list
│   ├── Labs_Landing/
│   │   └── index.html                                  # CyberNest Labs page & Software .zip Download Index
│   ├── Farms_Landing/
│   │   └── index.html                                  # CyberNest Farms page (HaaS, Hosting & Colocation)
│   └── ADMD_Landing/
│       └── index.html                                  # CyberNest ADMD page (Artistry, Design & Media Services)
└── Context/
    └── ProjDocs/
        ├── ROOT_CONTEXT/
        │   └── synth-ledger.css                        # Core theme stylesheet
        └── SoftwareZips/                               # Downloadable Software .zip Index Directory
            ├── index.html                              # Raw directory index of /SoftwareZips/
            ├── SHA256SUMS.txt                          # SHA-256 checksums for all 6 .zip archives
            ├── manifest.json                           # JSON metadata for the 6 archives
            ├── BlackRouteWebPublic-main.zip
            ├── KwikLogPro-main.zip
            ├── NestComm-main.zip
            ├── NestLink-main.zip
            ├── NestPatch-main.zip
            └── NestSBOM-main.zip
```

---

## 2. How to Deploy to GitHub Pages

All links across the site use relative paths (`AboutUs/index.html`, `../index.html`, etc.), so the site works out of the box on any GitHub Pages URL (`https://<username>.github.io/<repo-name>/`) or custom domain.

### Step 1: Test Locally (Optional)

Run a local static server to preview the site in your browser:

```bash
cd /home/auxk0rd/Desktop/WebPageStatic
python3 -m http.server 8000 --bind 127.0.0.1
```

Open `http://127.0.0.1:8000/index.html`.

### Step 2: Push to GitHub

1. Initialize Git (if not already a Git repo) and commit the site files:
   ```bash
   cd /home/auxk0rd/Desktop/WebPageStatic
   git init
   git branch -M main

   # Optional: If you want to keep Private governance docs out of a public repo,
   # add "Context/ProjDocs/ROOT_CONTEXT/Docs_Updated2026/Private/" to .gitignore first.

   git add .nojekyll index.html synth-ledger-ext.css update_archive_index.sh Handoff.md \
           LandingPg/ AboutUs/ ContactUs/ Depts/ Context/
   git commit -m "Initial commit: CyberNest Holdings LLC static website"
   ```

2. Add your GitHub remote and push:
   ```bash
   git remote add origin https://github.com/auxk0rd03/CyberNestHoldingsLanding.git
   git push -u origin main
   ```

### Step 3: Enable GitHub Pages

1. Open your repository on GitHub (`https://github.com/auxk0rd03/CyberNestHoldings` or `https://github.com/auxk0rd03/CyberNestHoldingsLanding`).
2. Click **Settings** $\rightarrow$ **Pages** (in the left sidebar).
3. Under **Build and deployment**:
   * **Source:** Select **Deploy from a branch**.
   * **Branch:** Select `main` and folder `/ (root)`, then click **Save**.
4. Wait ~1 minute for GitHub to publish the site (`https://auxk0rd03.github.io/CyberNestHoldings/`).

---

## 3. How to Update the Zipped Codebase Index (`CyberNest Labs`)

The downloadable `.zip` files for **CyberNest Labs** are served from `Context/ProjDocs/SoftwareZips/` and listed on:
* `Depts/Labs_Landing/index.html` (Main CyberNest Labs Software Index table)
* `Context/ProjDocs/SoftwareZips/index.html` (Raw `/SoftwareZips/` directory table)

### Updating an Existing Codebase `.zip`

1. Place your updated `.zip` file into its project folder under `Context/ProjDocs/<AppName>/` (or directly into `Context/ProjDocs/SoftwareZips/`).
2. Run the helper script from the repository root:
   ```bash
   ./update_archive_index.sh
   ```
   This script copies the `.zip` files into `Context/ProjDocs/SoftwareZips/`, updates `Context/ProjDocs/SoftwareZips/SHA256SUMS.txt`, and prints the exact file size and new SHA-256 hash for each archive:
   ```text
   ARCHIVE FILENAME               | SIZE (BYTES) | SHA-256 DIGEST
   --------------------------------------------------------------------------------
   BlackRouteWebPublic-main.zip   | 2675557      | 1498a8711792dd0fa8dacd221067a2878a645d0aebe5b026f54cdcacca455130
   KwikLogPro-main.zip            | 178072       | 27cfad218717f30cd47cbb5b77fe7a8d39d143cbc153fb2002a72927e8d590cb
   NestComm-main.zip              | 264210       | e8d1f94b74ca14f7dffe2c5259e5fce601137565e754f614be757083b6e16a52
   NestLink-main.zip              | 5152791      | da367642239d8201c33c4f4609e41d4801d19fa2d2f00fc3335cb443cb6706e0
   NestPatch-main.zip             | 176839       | 268840edcc55bfbd9c2db77ca59e635ddaf6ce47a0fb6ba887cf7ffe800d4431
   NestSBOM-main.zip              | 53881        | 4aafd856eb41817c8d25e54b3c6dd9ec6d01c1bd64b5c13baad6124e2e7d962a
   --------------------------------------------------------------------------------
   ```
3. To pull fresh archives directly from GitHub repositories automatically, run:
   ```bash
   ./update_archive_index.sh --pull-github
   ```
4. Active Working GitHub Repositories:
   * **BlackRouteWeb:** `https://github.com/auxk0rd03/BlackRouteWebPublic.git`
   * **NestPatch:** `https://github.com/auxk0rd03/NestPatch.git`
   * **NestLink:** `https://github.com/auxk0rd03/NestLink.git`
   * **NestComm:** `https://github.com/auxk0rd03/NestComm.git`
   * **NestSBOM:** `https://github.com/auxk0rd03/NestSBOM.git`
   * **KwikLogPro:** `https://github.com/auxk0rd03/KwikLogPro.git`
5. If the file size or SHA-256 hash changed, update the corresponding rows in:
   * `Depts/Labs_Landing/index.html`
   * `Context/ProjDocs/SoftwareZips/index.html`
   * `Context/ProjDocs/SoftwareZips/manifest.json`
6. Commit and push to `main`:
   ```bash
   git add Context/ProjDocs/SoftwareZips/ Depts/Labs_Landing/index.html
   git commit -m "Update CyberNest Labs software archives and repository links"
   git push
   ```

### Adding a New Software `.zip` to the Index

1. Copy the new `.zip` file (e.g., `NewTool-main.zip`) into `Context/ProjDocs/SoftwareZips/NewTool-main.zip`.
2. Run `./update_archive_index.sh` to update `SHA256SUMS.txt` and print its size and SHA-256 hash.
3. Add a new `<tr>` row to the table in `Depts/Labs_Landing/index.html`:
   ```html
   <tr>
     <td><strong>NewTool</strong></td>
     <td>Short description of what NewTool does.</td>
     <td class="val-muted">Rust / Go / Python / sh</td>
     <td class="num-right val-muted">150 KB</td>
     <td><a class="btn-bank" href="../../Context/ProjDocs/SoftwareZips/NewTool-main.zip" download="NewTool-main.zip">Download .zip</a></td>
   </tr>
   ```
4. Add a matching `<tr>` row to `Context/ProjDocs/SoftwareZips/index.html`:
   ```html
   <tr>
     <td><a href="NewTool-main.zip" download="NewTool-main.zip">NewTool-main.zip</a></td>
     <td class="num-right val-muted">150 KB</td>
     <td class="val-muted"><code>YOUR_NEW_SHA256_HASH_HERE</code></td>
     <td><a class="btn-bank" href="NewTool-main.zip" download="NewTool-main.zip">[DL]</a></td>
   </tr>
   ```

---

## 4. Google Form Configuration (`ContactUs/index.html`)

The Contact Us page (`ContactUs/index.html`) is configured to direct users to the active CyberNest Holdings LLC Google Form:
* **Active Google Form URL:** `https://forms.gle/HRJEPmp29yCTgir29`
* **Direct Email Citation:** `cybernestllc@gmail.com`

If you ever need to replace the Google Form link in the future, open `ContactUs/index.html` and update the `href="https://forms.gle/HRJEPmp29yCTgir29"` attribute on `#direct-google-form-link`.

---

## 5. Departmental Outlines: `CyberNest Farms` & `CyberNest ADMD`

Departmental outlines for **CyberNest Farms** and **CyberNest ADMD** are implemented across all respective landing and directory pages:

* **CyberNest Farms:** Operates a Hardware as a Service (HaaS) model to remove high CapEx barriers and maintenance burdens, lowering the barrier of entry for small businesses to access Enterprise-grade and secure IT & networking solutions. Offers core service plans, Web hosting, Server hosting, and Colocation.
* **CyberNest ADMD:** Artistry, Design, and Media department. Delivers branding solutions (logos, business cards, website visuals), social media account management for digital marketing sprints, and direct individual media solutions and services.

---

## 6. ToDo & Pending Data Checklist

The following items are tracked for upcoming updates as additional corporate documentation is finalized:

* **[x] ToDo 1 — CyberNest Farms Departmental Details:** Implemented HaaS, hosting, and colocation service outlines across `Depts/Farms_Landing/index.html`, `AboutUs/index.html`, `Depts/index.html`, and `index.html`.
* **[x] ToDo 2 — CyberNest ADMD Departmental Details:** Implemented Artistry, Design, and Media branding and custom media service outlines across `Depts/ADMD_Landing/index.html`, `AboutUs/index.html`, `Depts/index.html`, and `index.html`.
* **[ ] ToDo 3 — Public Media & Brand Assets (`Context/ProjDocs/ROOT_CONTEXT/Docs_Updated2026/Public_Media/`):**
  * Populate the currently empty `Public_Media/` directory with official company/departmental logos, diagrams, or verified site photography if desired on the static pages.
* **[ ] ToDo 4 — Federal Contracting Identifiers (`SAM.gov UEI` & `DLA CAGE Code`):**
  * Once initial SAM.gov entity registration completes (`POAM-2026-007` & `POAM-2026-008`), update `Pending Initial SAM.gov Registration (Not Yet Assigned)` in `Context/ProjDocs/ROOT_CONTEXT/Compliance/` with the issued 12-character SAM.gov UEI, 5-character DLA CAGE Code, and official DoD PIEE/SPRS submission confirmation.
* **[ ] ToDo 5 — Governing Document Effective Dates & Signatures:**
  * Populate the blank effective date and signature lines in `Operating_Agreement.docx`, `Member_Capital_Legder.docx`, `Holdings_General_NDA_v1.0.pdf`, and `Risk_Disclosure_and_Member_Acknowledgment_v1.0.pdf` once finalized signed copies are archived.

---

## 7. CyberNest Labs BlackRoute-Web VIDS Security Remediation & Edge Hardening

A black-box Vulnerability Identification & Diagnostic System (VIDS) audit conducted by **CyberNest Labs** (`BlackRoute-Web`) against `https://auxk0rd03.github.io/CyberNestHoldings/index.html` flagged 5 actionable security defects:

1. `[MEDIUM] Missing Content-Security-Policy (CSP)` (CWE-693)
2. `[MEDIUM] Missing Anti-Clickjacking Header (X-Frame-Options / frame-ancestors)` (CWE-1021)
3. `[LOW] Missing X-Content-Type-Options: nosniff` (CWE-16)
4. `[LOW] Missing Referrer-Policy Header` (CWE-200)
5. `[INFO] Missing Permissions-Policy` (CWE-250)

### Static Client & DOM Hardening Implementation

To remediate these vulnerabilities directly on static hosting without requiring backend infrastructure, defense-in-depth protections have been implemented across all HTML documents:

* **Strict Content Security Policy (`<meta http-equiv="Content-Security-Policy">`):**
  ```html
  <meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data: https:; font-src 'self'; connect-src 'self'; form-action 'self' https://docs.google.com https://forms.gle; frame-ancestors 'none'; base-uri 'self'; object-src 'none';">
  ```
  * Disallows inline scripts (`'unsafe-inline'`) and dynamic code evaluation (`'unsafe-eval'`).
  * Restricts form submissions exclusively to `'self'` and the official Google Form endpoints (`https://docs.google.com`, `https://forms.gle`).
  * Completely blocks Flash, Java applets, and plugins (`object-src 'none'`).
* **Frame-Busting & Anti-Clickjacking Defense (`anti-clickjack.js`):**
  * Modern browsers ignore `frame-ancestors` inside `<meta>` tags per W3C specification. To neutralize UI redressing and malicious framing on static platforms, `anti-clickjack.js` executes immediately in `<head>`:
    ```javascript
    if (window.top !== window.self) {
      try {
        if (window.top.location.host !== window.self.location.host) {
          window.top.location = window.self.location;
        }
      } catch (e) {
        if (document.documentElement) document.documentElement.style.display = 'none';
      }
    }
    ```
  * In addition, `<meta http-equiv="X-Frame-Options" content="DENY">` is included for clients that honor meta-level framing flags.
* **MIME-Sniffing Prevention (`<meta http-equiv="X-Content-Type-Options" content="nosniff">`):**
  * Enforces strict MIME typing in supporting clients.
* **Referrer Minimization (`<meta name="referrer" content="strict-origin-when-cross-origin">`):**
  * Prevents internal path exposure when navigating to external destinations.
* **Hardware & Sensor Privilege Lockdown (`<meta http-equiv="Permissions-Policy">`):**
  * Revokes camera, microphone, geolocation, USB, and payment access (`camera=(), microphone=(), geolocation=(), payment=(), usb=()`).
* **Zero Inline Styles:**
  * All legacy `style="..."` attributes were refactored into classes within `synth-ledger-ext.css` (`.mt-12`, `.mt-14`, `.font-12`), eliminating the need for `style-src 'unsafe-inline'`.

### Edge & Reverse Proxy Response Headers Configuration

GitHub Pages serves static assets directly from the `github.io` CDN, which does not allow custom HTTP response headers via repository configuration files. When fronting the domain with Cloudflare, Cloudflare Pages, AWS CloudFront, or an Nginx/Caddy reverse proxy, attach the preconfigured headers:

#### Cloudflare Pages / Edge Gateways (`_headers` file)
The included `_headers` file is located at the root of the repository:
```text
/*
  Content-Security-Policy: default-src 'self'; script-src 'self'; style-src 'self'; img-src 'self' data: https:; font-src 'self'; connect-src 'self'; form-action 'self' https://docs.google.com https://forms.gle; frame-ancestors 'none'; base-uri 'self'; object-src 'none';
  X-Frame-Options: DENY
  X-Content-Type-Options: nosniff
  Referrer-Policy: strict-origin-when-cross-origin
  Permissions-Policy: camera=(), microphone=(), geolocation=(), payment=(), usb=()
  Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```
Deploying this repository to Cloudflare Pages automatically parses `_headers`, yielding a **Surface Risk Score of 0 / 100** on BlackRoute-Web.

#### Cloudflare Worker Edge Proxy (`worker.js`)
If proxying `https://auxk0rd03.github.io/CyberNestHoldings/` through Cloudflare Workers without re-deploying, deploy `worker.js` directly to inject all 5 response headers into the network stream.

#### Nginx Reverse Proxy (`security-headers.conf`)
Include `security-headers.conf` within the Nginx `server` or `location` block:
```nginx
include /path/to/WebPageStatic/security-headers.conf;
```
This guarantees 100% compliance during automated DAST HTTP response evaluations by BlackRoute-Web or external vulnerability scanners.
