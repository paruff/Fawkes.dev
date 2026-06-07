# PR 3 — Fawkes Design System (FDS) Bootstrap

## Site Audit Summary

P0: 3 | P1: 5 | P2: 6 | P3: 4 findings

### P0 — Broken
| # | Finding | File | Fix |
|---|---------|------|-----|
| P0a | `.cta-button--secondary` light-mode definition is missing — only defined inside `@media (prefers-color-scheme: dark)` | `assets/css/main.css` | Add light-mode definition before dark block |
| P0b | Broken dark-mode CSS nesting — `.dojo-callout` dark override nested inside `.cta-button--secondary` dark block | `assets/css/main.css:497-529` | Un-nest and reorganize all dark overrides |
| P0c | Learn hub links use trailing-slash paths (`/learn/dora-primer/`) instead of `.html` — will 404 | `learn/index.md` | Fix 3 guide links to use `.html` extension |

### P1 — Conversion
| # | Finding | File | Fix |
|---|---------|------|-----|
| P1a | DORA stack page shows "live" badge but text says "GitHub repo coming soon" — contradictory trust signals | `dora/index.md` | Change badge to "coming soon" |
| P1b | No global typography scale — body has no `font-size`/`line-height`; headings have no base styling | `assets/css/main.css` | Add `html { font-size: 16px }`, `body { font-size: 16px; line-height: 1.6; }`, base heading rules |
| P1c | Card hover states missing — `.stack-card`, `.capability-card` are static | `assets/css/main.css` | Add `hover: border-color #16a34a, box-shadow` |
| P1d | No focus ring on global `<a>` elements or `.cta-button` | `assets/css/main.css` | Add `a:focus-visible` and `.cta-button:focus-visible` outline rules |

### P2 — Quality
| # | Finding | File | Fix |
|---|---------|------|-----|
| P2a | No code block left border accent | `assets/css/main.css` | Add `border-left: 3px solid #16a34a` |
| P2b | Card border color `#d1d5db` inconsistent with canonical `#e5e7eb` | `assets/css/main.css:174` | Change to `#e5e7eb` |
| P2c | `.dojo-callout` dark mode missing `border-color` override | `assets/css/main.css` | Add `border-color: #374151` |
| P2d | `.guide-meta__next` link color not overridden in dark mode | `assets/css/main.css` | Add dark override |

### P3 — Polish
| # | Finding | File | Fix |
|---|---------|------|-----|
| P3a | Blog post only ~180 words, needs expansion | `_posts/*.md` | Expand to 800-1200 words |
| P3b | DORA AI Capabilities is plain text — no visual stack mapping | `index.md` | Rewrite as 2-col mapping |
| P3c | Homepage body missing explicit `background: #fff` in light mode | `assets/css/main.css` | Add `body { background: #fff }` |

---

## Sprint Plan

### Sprint 1 — Foundation (tokens + typography)

| # | Issue | File | Dependencies |
|---|-------|------|-------------|
| 1.1 | Add design token table to AGENTS.md Section 6 | `AGENTS.md` | None |
| 1.2 | Add global typography scale: html/body base, H1-H3 rules with mobile breakpoints | `assets/css/main.css` | 1.1 |
| 1.3 | Standardize card borders `#d1d5db` → `#e5e7eb` | `assets/css/main.css` | 1.1 |
| 1.4 | Add `.problem-statement` explicit `color: #374151` | `assets/css/main.css` | 1.2 |

### Sprint 2 — Component styling

| # | Issue | File | Dependencies |
|---|-------|------|-------------|
| 2.1 | Add card hover states (border-color, shadow, transition) | `assets/css/main.css` | 1.3 |
| 2.2 | Add global link focus ring + `.cta-button:focus-visible` | `assets/css/main.css` | 1.1 |
| 2.3 | Add code block left border accent | `assets/css/main.css` | None |
| 2.4 | Add inline badge styling (green pill, amber pill) | `assets/css/main.css` | 1.1 |
| 2.5 | Add `pre` and `code` global base styles | `assets/css/main.css` | None |

### Sprint 3 — Dark mode fixes + DORA mapping

| # | Issue | File | Dependencies |
|---|-------|------|-------------|
| 3.1 | Fix broken dark-mode CSS nesting — un-nest `.cta-button--secondary` and `.dojo-callout` | `assets/css/main.css` | ✅ Done |
| 3.2 | Add `.cta-button--secondary` light mode | `assets/css/main.css` | ✅ Done |
| 3.3 | Complete `.dojo-callout` dark mode (border-color, fix duplication) | `assets/css/main.css` | ✅ Done |
| 3.4 | Add `.guide-meta__next` dark mode link color | `assets/css/main.css` | ✅ Done |
| 3.5 | Rewrite DORA AI Capabilities as 2-col stack-to-capability mapping with links | `index.md` + CSS | ⬜ Deferred |
| 3.6 | Change DORA stack page badge from "live" to "coming soon" | `dora/index.md` | ✅ Done |
| 3.7 | Fix learn hub guide links: trailing-slash → `.html` | `learn/index.md` | ✅ Already correct — no change needed |

### Sprint 4 — Content

| # | Issue | File | Dependencies |
|---|-------|------|-------------|
| 4.1 | Expand founding blog post to 800–1200 words | `_posts/*.md` | None |
| 4.2 | Reorder homepage so blog listing doesn't appear after footer | `_layouts/home.html`, `index.md` | None |

---

## Design Token Table

### Color Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `color-brand` | `#16a34a` | CTAs, live badges, hover borders |
| `color-brand-hover` | `#15803d` | CTA hover |
| `color-brand-dark` | `#4ade80` | CTA text in dark mode |
| `color-brand-ghost` | `#f0fdf4` | Subtle brand bg |
| `color-success-bg` | `#dcfce7` | Live badge bg |
| `color-warning-bg` | `#fef3c7` | Coming-soon badge bg |
| `color-warning-text` | `#d97706` | Coming-soon badge text |
| `color-text-primary` | `#111827` | H1–H3, strong emphasis |
| `color-text-secondary` | `#374151` | Body paragraphs |
| `color-text-muted` | `#6b7280` | Metadata, dates |
| `color-text-on-brand` | `#ffffff` | CTA button text |
| `color-border` | `#e5e7eb` | Cards, dividers |
| `color-border-strong` | `#d1d5db` | Active borders |
| `color-bg` | `#ffffff` | Page, cards |
| `color-bg-subtle` | `#f9fafb` | Code blocks |
| `color-bg-hover` | `#f3f4f6` | Nav link hover |
| `color-bg-dark` | `#111827` | Dark mode page |
| `color-bg-card-dark` | `#1f2937` | Dark mode cards |
| `color-border-dark` | `#374151` | Dark mode borders |

### Spacing Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `space-1` | 8px | Tight grouping |
| `space-2` | 16px | Card padding (mobile), between items |
| `space-3` | 24px | Card padding (desktop), section spacing |
| `space-4` | 32px | Between major sections |
| `space-6` | 48px | Hero padding, major breaks |
| `space-8` | 64px | Page-level rhythm |

### Typography Tokens

| Token | Desktop | Mobile (≤640px) | Weight | Color |
|-------|---------|-----------------|--------|-------|
| `text-h1` | 36px | 28px | 700 | `#111827` |
| `text-h2` | 24px | 20px | 600 | `#111827` |
| `text-h3` | 18px | 18px | 600 | `#111827` |
| `text-body` | 16px (1.6 lh) | — | 400 | `#374151` |
| `text-small` | 14px | — | 400 | `#6b7280` |
| `text-code` | 14px | — | 400 | `#111827` |

### Radius Tokens

| Token | Value | Usage |
|-------|-------|-------|
| `radius-sm` | 4px | Code blocks |
| `radius-md` | 6px | Buttons |
| `radius-lg` | 8px | Cards |
| `radius-xl` | 12px | Callouts, email capture |

---

## Recommended Execution Order

1. **Sprint 3 first** (3.1, 3.2, 3.3, 3.6, 3.7) — fixes actively broken dark-mode CSS and learn hub 404s
2. **Sprint 1** (1.1–1.4) — token foundation + typography scale
3. **Sprint 2** (2.1–2.5) — component polish on top of tokens
4. **Sprint 4** (4.1–4.2) — content work, lowest dependency
5. **3.5 standalone** — DORA mapping can slot into any sprint after Sprint 1

*Last updated: 2026-06-06*
