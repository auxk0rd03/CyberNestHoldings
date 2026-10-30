# STYLE.MD // SYS.01 "NOCTURNAL SYNTH-LEDGER"
**Aesthetic Triad:** Webcore $\times$ Vocaloid $\times$ Fintech  
**Visual Reference:** 90s Anime OVA Cel-Shading / *Call of the Night* Nocturnal Palette  
**Target Architecture:** RPGS (Rust, Python, Go, Shell) + HTMX HTML-Over-The-Wire

---

## 1. Core Philosophy & The Aesthetic Triad

The **Nocturnal Synth-Ledger** design system rejects modern corporate SaaS tropes (rounded cards, soft drop shadows, white space bloat, and heavy JavaScript state engines). Instead, it treats the browser viewport as an **after-hours institutional financial terminal fused with a late-90s Yamaha voice synthesizer**.

Every view in the system must balance three distinct pillars:

### I. Webcore & 90s OVA Cel-Cleanliness (The Chassis)
* **Nocturnal Atmosphere:** High-contrast night-sky backgrounds paired with twilight purples and warm, film-cel off-whites.
* **Exposed Wireframe Framing:** Inspired by 90s anime production layouts and early web table borders, structural containers use crisp `1px solid` rules that deliberately intersect and extend past content boxes.
* **Flat Cel-Shaded Surfaces:** Zero linear or radial gradients on UI panels. Depth is communicated strictly through flat color-blocking and hard `1px` borders, accompanied by an optional, ultra-subtle CRT scanline texture across the viewport.

### II. Vocaloid & Synthesizer UI (The Telemetry)
* **Voicebank & Channel Indexing:** Navigation tabs, microservices, and document sections are labeled like synthesizer memory slots (`CV-01`, `BANK_01`, `CH_00 // MONITOR`).
* **ASCII & Step-Bar Visualization:** Instead of heavy canvas chart libraries, real-time metrics (liquidity depth, CPU load, burn rate, memory allocation) are rendered as deterministic DAW-style ASCII step-meters (`||||||||||||....`) and rectangular block arrays.
* **Signal Cyan Highlights:** Primary interactive focus, active states, and positive yield metrics use the signature Vocaloid turquoise/cyan (`#36A19D`).

### III. Institutional Fintech (The Information Density)
* **Tabular Discipline:** High-density monospace data tables, double-entry ledger alignment, and strict key-value metadata headers.
* **Deterministic State Badges:** Every transaction, daemon, or document node displays an explicit bracketed status (`[SETTLED]`, `[LOCKED]`, `[SYNC_OK]`, `[ERR_HALT]`).
* **Zero-Latency Partial Swaps:** Powered by HTMX, only the target rectangular cell or table body updates over the wire.

---

## 2. The Law of Orthogonal Geometry

This design system enforces **strict Euclidean rectangularity**. Every component in the DOM is a rectangle or a straight horizontal/vertical line.

1. **Zero Border Radius (`0px` Mandate):**
   * `border-radius: 0px !important;` is applied globally. Circles, pills, and smoothed corners are strictly forbidden.
2. **Zero Drop Shadows or Blur:**
   * `box-shadow: none;` and `backdrop-filter: none;` at all times. If a modal or popover requires elevation, use a solid `1px solid var(--accent-cyan)` border and a flat, hard-offset rectangular shadow (`4px 4px 0px #000000`).
3. **Single-Pixel Structural Rules:**
   * All borders must be `1px solid` or `2px solid` (for active focus indicators). Never use `3px+` borders, dashed borders, or outset/inset 3D bevels.
4. **Intersecting Frame Overhangs:**
   * Primary layout shells use outer `border-right` and `border-bottom` framing lines that frame the workspace like an architectural blueprint or OVA key-frame guide.

---

## 3. Color Palette & Cel-Paint Tokens

To preserve the 90s OVA film look, **pure black (`#000000`) and pure white (`#FFFFFF`) are banned**. Using the warm cream of a cel-painted crescent moon (`#DCD5C6`) against deep nocturnal navy (`#080C12`) eliminates halation and eye strain during late-night operations.

### Color Token Matrix

| Token Name | Hex Code | RGB Value | Role in System |
| :--- | :--- | :--- | :--- |
| `--bg-void` | `#080C12` | `rgb(8, 12, 18)` | Root viewport background (Nocturnal sky void) |
| `--bg-panel` | `#101420` | `rgb(16, 20, 32)` | Primary container, card, and table surface |
| `--bg-purple` | `#261B38` | `rgb(38, 27, 56)` | Twilight purple for active rows, headers, & hover states |
| `--border-muted` | `#1E2436` | `rgb(30, 36, 54)` | Internal table row dividers and inactive grid lines |
| `--accent-purple` | `#523B78` | `rgb(82, 59, 120)` | Structural panel borders and secondary badges |
| `--accent-cyan` | `#36A19D` | `rgb(54, 161, 157)` | Vocaloid signal cyan: Primary borders, active tabs, positive delta |
| `--text-primary` | `#DCD5C6` | `rgb(220, 213, 198)` | Cel-cream off-white for body copy, figures, and headers |
| `--text-muted` | `#687888` | `rgb(104, 120, 136)` | Slate blue-grey for timestamps, column headers, and units |
| `--status-neg` | `#B85D78` | `rgb(184, 93, 120)` | Muted crimson-rose for outflows, drawdowns, and errors |
| `--status-warn` | `#C9A654` | `rgb(201, 166, 84)` | OVA moon-amber for pending locks and latency warnings |

---

## 4. Typography & Tabular Discipline

A Fintech $\times$ Synth interface lives or dies by character alignment.

* **Font Stack:** Strictly monospace across the entire document. No proportional sans-serif or serif fonts.
  ```css
  --font-mono: 'JetBrains Mono', 'IBM Plex Mono', 'Fira Code', monospace;
  ```
* **Tabular Numerals:** All numeric columns, timestamps, and step-meters must enforce fixed-width glyph rendering:
  ```css
  font-variant-numeric: tabular-nums;
  ```
* **Case & Formatting Conventions:**
  * **System Headers & Channel IDs:** `UPPERCASE_WITH_UNDERSCORES` (e.g., `CH_01 // LIQUIDITY_POOL`, `SEQ_ID`).
  * **Status Indicators:** Enclosed in square brackets (`[SETTLED]`, `[PENDING]`, `[EXEC_OK]`).
  * **Currency & Deltas:** Explicit `+` or `-` prefix on all delta values (`+1,420.00`, `-0.0425`).

---

## 5. Master CSS Stylesheet (`synth-ledger.css`)

Include this stylesheet once in the root HTML shell. All dynamic HTMX fragments emitted by **Rust, Python, Go, or Shell** inherit these rules automatically using minimal semantic markup.

```css
:root {
  --bg-void: #080C12;
  --bg-panel: #101420;
  --bg-purple: #261B38;
  --border-muted: #1E2436;
  --accent-purple: #523B78;
  --accent-cyan: #36A19D;
  --text-primary: #DCD5C6;
  --text-muted: #687888;
  --status-neg: #B85D78;
  --status-warn: #C9A654;
  --font-mono: 'JetBrains Mono', 'IBM Plex Mono', monospace;
}

/* 1. Global Orthogonal Enforcement */
*, *::before, *::after {
  box-sizing: border-box;
  border-radius: 0px !important;
  box-shadow: none !important;
  margin: 0;
  padding: 0;
}

body {
  background-color: var(--bg-void);
  color: var(--text-primary);
  font-family: var(--font-mono);
  font-size: 13px;
  line-height: 1.45;
  font-variant-numeric: tabular-nums;
  padding: 24px;
  /* 90s OVA CRT Scanline Overlay */
  background-image: linear-gradient(
    rgba(18, 16, 16, 0) 50%, 
    rgba(0, 0, 0, 0.28) 50%
  );
  background-size: 100% 4px;
}

/* 2. Exposed OVA Wireframe Outer Shell */
.frame-shell {
  max-width: 1200px;
  margin: 0 auto;
  border-right: 1px solid var(--accent-cyan);
  border-bottom: 1px solid var(--accent-cyan);
  padding-right: 16px;
  padding-bottom: 16px;
}

/* 3. Top Telemetry Ticker */
.status-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border: 1px solid var(--accent-cyan);
  background: var(--bg-panel);
  padding: 6px 12px;
  margin-bottom: 16px;
  text-transform: uppercase;
  letter-spacing: 0.08em;
}

.badge-cv {
  background: var(--accent-cyan);
  color: var(--bg-void);
  font-weight: 700;
  padding: 1px 6px;
  margin-right: 8px;
}

/* 4. Rectangular Grid & Panels */
.grid-workspace {
  display: grid;
  grid-template-columns: 300px 1fr;
  gap: 16px;
  align-items: start;
}

.panel {
  background: var(--bg-panel);
  border: 1px solid var(--accent-purple);
  padding: 12px;
}

.panel-header {
  border-bottom: 1px solid var(--accent-cyan);
  padding-bottom: 6px;
  margin-bottom: 12px;
  display: flex;
  justify-content: space-between;
  color: var(--accent-cyan);
  font-weight: 700;
  text-transform: uppercase;
}

/* 5. Vocaloid Bank Navigation / HTMX Triggers */
.nav-bank {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-bottom: 12px;
}

button, .btn-bank {
  background: var(--bg-void);
  color: var(--text-primary);
  border: 1px solid var(--accent-purple);
  padding: 6px 12px;
  font-family: var(--font-mono);
  font-size: 12px;
  cursor: pointer;
  text-transform: uppercase;
}

button:hover, .btn-bank:hover, .btn-bank.active {
  background: var(--bg-purple);
  border-color: var(--accent-cyan);
  color: var(--accent-cyan);
}

/* 6. Synth Step-Meters */
.param-block {
  margin-bottom: 10px;
}

.param-meta {
  display: flex;
  justify-content: space-between;
  font-size: 11px;
  color: var(--text-muted);
}

.step-meter {
  color: var(--accent-cyan);
  letter-spacing: 2px;
  font-size: 12px;
  overflow: hidden;
  white-space: nowrap;
}

/* 7. Fintech Ledger Tables */
table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  text-align: left;
  padding: 8px 10px;
  border-bottom: 1px solid var(--border-muted);
}

th {
  color: var(--text-muted);
  font-weight: 400;
  border-bottom: 1px solid var(--accent-purple);
  font-size: 11px;
  text-transform: uppercase;
}

tr:hover {
  background: var(--bg-purple);
}

.num-right { text-align: right; }
.val-pos   { color: var(--accent-cyan); }
.val-neg   { color: var(--status-neg); }
.val-warn  { color: var(--status-warn); }
.val-muted { color: var(--text-muted); }

/* 8. HTMX Request States */
.htmx-indicator {
  opacity: 0;
  color: var(--status-warn);
  transition: opacity 75ms linear;
}
.htmx-request .htmx-indicator,
.htmx-request.htmx-indicator {
  opacity: 1;
}
```

---

## 6. RPGS + HTMX Polyglot Architecture Contract

In an **RPGS (Rust, Python, Go, Shell) + HTMX** stack, different backend utilities or microservices often serve different parts of the document:
* **Rust:** High-frequency ledger engines, order-book matching, or binary log parsers.
* **Python:** Financial modeling, anomaly detection, or pandas/Polars report generation.
* **Go:** Core HTTP router, session multiplexer, and concurrent API aggregator.
* **Shell (Bash/POSIX sh):** System telemetry, cron audit logs, ZFS/disk health, and process monitors via CGI or lightweight socket daemons.

To ensure **zero visual drift** across all four languages, every backend service must adhere to the **Orthogonal HTML Fragment Contract**:

### Rule 1: Never Return JSON to the Browser
Every RPGS endpoint called by `hx-get`, `hx-post`, or `hx-delete` returns raw, unstyled, semantic HTML fragments using the shared classes defined in Section 5.

### Rule 2: Standardized ASCII Step-Meter Formula
When any language in the RPGS stack renders a Vocaloid-style telemetry bar (`20` steps wide), it computes filled pipes (`|`) vs. empty dots (`.`):
$$\text{Filled Steps} = \text{round}\left(\frac{\text{Percentage}}{100} \times 20\right)$$

---

### Language Implementation Patterns

#### A. Rust (High-Speed Ledger Row Fragment)
Used for deterministic transaction rows (`<tr>`). Zero JSON serialization overhead; write directly to a string buffer or `maud`/`askama` template.

```rust
pub fn render_ledger_row(seq_id: u32, timestamp: &str, channel: &str, delta: f64, status: &str) -> String {
    let (delta_class, sign) = if delta >= 0.0 {
        ("val-pos", "+")
    } else {
        ("val-neg", "")
    };

    format!(
        r#"<tr id="seq-{seq_id}">
            <td>#01-{seq_id:04}</td>
            <td class="val-muted">{timestamp}</td>
            <td>{channel}</td>
            <td class="num-right {delta_class}">{sign}{delta:.2}</td>
            <td>[{status}]</td>
        </tr>"#
    )
}
```

#### B. Python (Analytics & Documentation Block Fragment)
Used for financial model summaries, risk matrices, or dynamic markdown-to-HTML doc blocks swapped into `#ledger-body`.

```python
def render_synth_telemetry(label: str, pct: int, status_tag: str = "NOMINAL") -> str:
    filled = max(0, min(20, round((pct / 100) * 20)))
    bar = ("|" * filled) + ("." * (20 - filled))
    tone_class = "val-warn" if pct > 85 else "val-pos"
    
    return f"""
    <div class="param-block">
      <div class="param-meta">
        <span>{label.upper()}</span>
        <span class="{tone_class}">{pct}% [{status_tag}]</span>
      </div>
      <div class="step-meter">{bar}</div>
    </div>
    """
```

#### C. Go (Bank Switcher & HTMX Container Partial)
Used by the primary HTTP gateway to serve tabbed documentation panels or aggregate fragments from sub-services.

```go
package ui

import "fmt"

func RenderDocPanel(bankID string, title string, bodyHTML string) string {
	return fmt.Sprintf(`
	<section class="panel" id="bank-%s">
		<div class="panel-header">
			<span>%s // SPEC_VIEW</span>
			<span class="htmx-indicator">[SYNCING_NODE...]</span>
		</div>
		<div class="doc-content">
			%s
		</div>
	</section>`, bankID, title, bodyHTML)
}
```

#### D. Shell / POSIX `sh` (Zero-Dependency System & Cron Telemetry)
Even a simple `sh` script triggered via `inetd`, `socat`, or a Go `os/exec` handler can emit native Nocturnal Synth-Ledger UI fragments using `printf`.

```sh
#!/bin/sh
# Emit an HTMX-ready rectangular telemetry table row from raw shell metrics

SEQ_ID="$1"
MEM_PCT="$2"
 TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S")

if [ "$MEM_PCT" -gt 80 ]; then
  CLASS="val-neg"
  STATE="HIGH_LOAD"
else
  CLASS="val-pos"
  STATE="SETTLED"
fi

printf '<tr>
  <td>#SH-%s</td>
  <td class="val-muted">%s</td>
  <td>SYS_DAEMON // MEM_AUDIT</td>
  <td class="num-right %s">%s%%</td>
  <td>[%s]</td>
</tr>\n' "$SEQ_ID" "$TIMESTAMP" "$CLASS" "$MEM_PCT" "$STATE"
```

---

## 7. Component Do's & Don'ts Checklist

* **DO** use `1px solid` cyan (`#36A19D`) and twilight purple (`#523B78`) borders to separate every logical group.
* **DO** align all currency, percentages, and cryptographic hashes to the right (`text-align: right`) inside tables.
* **DO** use ASCII characters (`//`, `::`, `[ ]`, `|||...`) as first-class structural ornamentation—they cost zero bytes and work identically in Rust, Python, Go, and Shell output.
* **DON'T** introduce `border-radius`, `box-shadow`, or CSS transitions slower than `75ms`. Instant, snappy state changes reinforce the 90s hardware synthesizer feel.
* **DON'T** use spinners or rotating SVG loaders. Use blinking or static bracketed text indicators (`[LOADING...]`, `[SYNC_WAIT]`) via `.htmx-indicator`.