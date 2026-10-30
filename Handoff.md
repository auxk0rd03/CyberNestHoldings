# CyberNest Holdings LLC // Static Website Handoff Manual

* **Company:** CyberNest Holdings LLC (Pennsylvania Manager-Managed Operating LLC)
* **Departments:** CyberNest Labs, CyberNest Farms, CyberNest ADMD
* **Leadership:** William R. M. (Auxk0rd) — President & Chief Architect | James D. J. (D) — CEO
* **Official Contact:** `cybernestllc@gmail.com`
* **Theme:** `Context/ProjDocs/ROOT_CONTEXT/synth-ledger.css` (`SYS.01 // NOCTURNAL SYNTH-LEDGER`)

---

## 1. Site Overview & Directory Structure

This repository is a pure static HTML/CSS website with an early-internet Webcore layout styled using `synth-ledger.css`. It requires zero build tools, bundlers, or backend servers.

```text
WebPageStatic/
├── .nojekyll                                           # Tells GitHub Pages to serve all folders/files directly
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
│   │   └── index.html                                  # CyberNest Farms page (body text: N/A)
│   └── ADMD_Landing/
│       └── index.html                                  # CyberNest ADMD page (body text: N/A)
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
   BlackRouteWebPublic-main.zip   | 2667995      | cb658fb51afae77efdd380580d7c8f70ab8f71509ef74eaeb952db8e13d1bf11
   KwikLogPro-main.zip            | 172462       | 36ce51f0aeb06d449c9f38cc10d0afe61513d4ad56f52eef6f8c02d619d3de2d
   NestComm-main.zip              | 248168       | c25b2c5dbfaf14271b8b9cec6fba5f62fadb416c01d5f581491b6cbc04f9ba1a
   NestLink-main.zip              | 5139945      | f0e48e5e4dd5877a083fbf8d42d499a2a0c39e913e03483fd3cf56f41384f0bc
   NestPatch-main.zip             | 155298       | 5f64521f893f5258044a57b530ecfa9b928ed2e686749015dddd70f46cfd5891
   NestSBOM-main.zip              | 47447        | 3f4d917e4c0187619b8647c4d859e753c79a5f6cbc1e4fddf776020dff31cd1c
   ```
3. If the file size or SHA-256 hash changed, update the corresponding row in:
   * `Depts/Labs_Landing/index.html`
   * `Context/ProjDocs/SoftwareZips/index.html`
4. Commit and push to `main`:
   ```bash
   git add Context/ProjDocs/SoftwareZips/ Depts/Labs_Landing/index.html
   git commit -m "Update CyberNest Labs software archives"
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

## 5. How to Update `CyberNest Farms` & `CyberNest ADMD` Copy

Currently, `Depts/Farms_Landing/index.html` and `Depts/ADMD_Landing/index.html` (and their corresponding sections on `AboutUs/index.html`, `Depts/index.html`, `index.html`, `LandingPg/index.html`, and `CyberNestHoldings/index.html`) contain `N/A` in the body text. When official descriptions for those departments are ready, replace `<p>N/A</p>` in those files with the approved department copy.

---

## 6. ToDo & Pending Data Checklist

The following items are currently marked `N/A` or pending in the context archive and should be populated as official corporate documentation is finalized:

* **[ ] ToDo 1 — CyberNest Farms Departmental Details (`Depts/Farms_Landing/index.html`, `AboutUs/index.html`, `Depts/index.html`, `index.html`):**
  * Replace `<p>N/A</p>` with verified operational use-case descriptions, workflows, and departmental project details for **CyberNest Farms** (currently only its internal department status and `10,000` Capital Unit allocation are documented in `Context/ProjDocs`).
* **[ ] ToDo 2 — CyberNest ADMD Departmental Details (`Depts/ADMD_Landing/index.html`, `AboutUs/index.html`, `Depts/index.html`, `index.html`):**
  * Replace `<p>N/A</p>` with verified operational use-case descriptions, design/marketing deliverables, and portfolio assets for **CyberNest ADMD (Artistry Design and Marketing Department)** (currently only its formal name, internal department status, and `3,000` Capital Unit allocation are documented in `Context/ProjDocs`).
* **[ ] ToDo 3 — Public Media & Brand Assets (`Context/ProjDocs/ROOT_CONTEXT/Docs_Updated2026/Public_Media/`):**
  * Populate the currently empty `Public_Media/` directory with official company/departmental logos, diagrams, or verified site photography if desired on the static pages.
* **[ ] ToDo 4 — Federal Contracting Identifiers (`SAM.gov UEI` & `DLA CAGE Code`):**
  * Once initial SAM.gov entity registration completes (`POAM-2026-007` & `POAM-2026-008`), update `Pending Initial SAM.gov Registration (Not Yet Assigned)` in `Context/ProjDocs/ROOT_CONTEXT/Compliance/` with the issued 12-character SAM.gov UEI, 5-character DLA CAGE Code, and official DoD PIEE/SPRS submission confirmation.
* **[ ] ToDo 5 — Governing Document Effective Dates & Signatures:**
  * Populate the blank effective date and signature lines in `Operating_Agreement.docx`, `Member_Capital_Legder.docx`, `Holdings_General_NDA_v1.0.pdf`, and `Risk_Disclosure_and_Member_Acknowledgment_v1.0.pdf` once finalized signed copies are archived.
