# PR 4 — Design System: Foundation, Components & Content (FDS Phase 2)

> Previous: PR 3 Sprint 3 completed — dark mode fixes, nav hover, DORA badge
> Next: PR 4 infra — agent consolidation, MCP setup (see `plan.md` PR 4 section)

---

## Complete Site Audit — All Findings

### P0 — Broken (3 issues)

| #   | Finding                                                                                                                                    | File                    | Fix                                                                                                | Effort |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- | -------------------------------------------------------------------------------------------------- | ------ |
| P0a | Blog listing renders AFTER custom footer — minima `home.html` layout renders `{{ content }}` then blog list                                | `_layouts/home.html`    | Move blog list rendering INTO `index.md` content area, or restructure `home.html` to split content | S      |
| P0b | Minima theme `.site-footer` renders redundantly below `.home-footer` — two footers on homepage                                             | `_layouts/default.html` | Suppress minima footer on homepage via `page.layout == "home"` conditional in default.html         | XS     |
| P0c | Maintainer bio `"Built by @paruff..."` in `index.md` renders as `<h2>` — Markdown `---` separator creates heading instead of content break | `index.md`              | Wrap maintainer bio in `<p>` tags or restructure to avoid `---` separator creating an H2           | XS     |

### P1 — Conversion (6 issues)

| #   | Finding                                                                           | File                                               | Fix                                                                                                   | Effort |
| --- | --------------------------------------------------------------------------------- | -------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ------ |
| P1a | No screenshots on any stack page — placeholder removed but nothing replaced       | `obs/index.md`, `pipe/index.md`, etc.              | Add real terminal/Grafana screenshots or remove screenshot sections entirely                          | M      |
| P1b | DORA AI Capabilities are plain text cards with no visual connection to stacks     | `index.md` + `assets/css/main.css`                 | Rewrite as 2-col stack-to-capability mapping with colored badges, stack icons, and links (Sprint 3.5) | M      |
| P1c | "Stacks" nav dropdown title is `<p>` text, not clickable — no keyboard activation | `_includes/header.html`                            | Make group title accessible or add visual affordance that it's a label, not a link                    | XS     |
| P1d | No favicon on any page — blank tab icon in browser                                | `_includes/header.html` or `_layouts/default.html` | Add `<link rel="icon">` to default layout header                                                      | XS     |
| P1e | No 404 page — GitHub Pages default shows when URL is wrong                        | `404.html` (new)                                   | Create custom 404 page with nav links back to main sections                                           | XS     |
| P1f | Global `<a>` elements have no focus ring — WCAG 2.4.7 failure                     | `assets/css/main.css`                              | Add `a:focus-visible { outline: 2px solid #16a34a; outline-offset: 2px; }`                            | XS     |

### P2 — Quality (12 issues)

| #   | Finding                                                                                                                                       | File                                                       | Fix                                                                                                                                                                                   | Effort |
| --- | --------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| P2a | No global typography scale — `body` has no `font-size` or `line-height`; H1-H3 have no base rules                                             | `assets/css/main.css`                                      | Add `html { font-size: 16px }`, `body { font-size: 16px; line-height: 1.6; }`, H1-H3 rules with mobile breakpoints                                                                    | S      |
| P2b | Card borders use `#d1d5db` instead of canonical `#e5e7eb` on `.email-capture`, `.stack-card`, `.capability-card`, `.dojo-callout`, `.try-now` | `assets/css/main.css`                                      | Change all `#d1d5db` to `#e5e7eb`                                                                                                                                                     | M      |
| P2c | No card hover states — `.stack-card`, `.capability-card` are static                                                                           | `assets/css/main.css`                                      | Add `hover: border-color #16a34a, box-shadow 0 2px 8px rgba(22,163,74,0.12), transition 150ms ease`                                                                                   | S      |
| P2d | No code block styling — `<pre>`, `<code>` have no base rules                                                                                  | `assets/css/main.css`                                      | Add `pre { background: #f9fafb; border: 1px solid #e5e7eb; border-left: 3px solid #16a34a; border-radius: 4px; padding: 16px; font-size: 14px; overflow-x: auto; }` and `code` styles | S      |
| P2e | No inline badge styling — using external `img.shields.io` URLs instead of styled CSS pills                                                    | `assets/css/main.css`                                      | Add `.badge { display: inline-block; padding: 2px 10px; border-radius: 12px; font-size: 12px; font-weight: 600; }` with `.badge--live` and `.badge--coming-soon` variants             | S      |
| P2f | `.problem-statement` has no explicit `color` — inherits browser default                                                                       | `assets/css/main.css`                                      | Add `color: #374151`                                                                                                                                                                  | XS     |
| P2g | Blog post is ~180 words — too short for founding story                                                                                        | `_posts/2026-05-11-why-im-building-*.md`                   | Expand to 800–1200 words with: problem background, solution evolution, roadmap, call to action                                                                                        | L      |
| P2h | No breadcrumb navigation on deeper pages — visitors have no orientation                                                                       | `_includes/breadcrumbs.html` (new) + `assets/css/main.css` | Add breadcrumb include for learn guides and stack pages                                                                                                                               | S      |
| P2i | Learn guides have no "← Back to all guides" link at top                                                                                       | `_includes/guide-meta.html`                                | Add back-to-learn link alongside read time                                                                                                                                            | XS     |
| P2j | No explicit `body { background: #fff }` in light mode — relies on browser default                                                             | `assets/css/main.css`                                      | Add to body rule                                                                                                                                                                      | XS     |
| P2k | `.cta-button` has no `focus-visible` outline — only hover is styled                                                                           | `assets/css/main.css`                                      | Add `.cta-button:focus-visible { outline: 2px solid #16a34a; outline-offset: 2px; }`                                                                                                  | XS     |
| P2l | Dark mode: `.try-now`, `.email-capture` lack proper dark card styling (border-color inconsistency)                                            | `assets/css/main.css`                                      | Audit all dark mode overrides for consistency                                                                                                                                         | S      |

### P3 — Polish (7 issues)

| #   | Finding                                                                                                  | File                                            | Fix                                                                                                              | Effort |
| --- | -------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | ------ |
| P3a | RSS subscribe link appears after blog listing — low value for primary audience                           | `_layouts/home.html`                            | Remove or move to footer                                                                                         | XS     |
| P3b | No transition/animation for nav panel opening — appears/disappears instantly                             | `assets/css/main.css`                           | Add `opacity` and `transform` transition to `.main-nav` open/close                                               | XS     |
| P3c | Stack pages are visually similar — no color differentiation between Obs/Pipe/DORA/Sec/DevX               | `assets/css/main.css` + stack pages             | Add per-stack accent color on hero section                                                                       | S      |
| P3d | Homepage has no visual anchor for "From the blog" section — blends into content                          | `assets/css/main.css`                           | Add section heading styling or separator                                                                         | XS     |
| P3e | No `prefers-reduced-motion` override for transitions                                                     | `assets/css/main.css`                           | Add `@media (prefers-reduced-motion: reduce) { *, *::before, *::after { transition-duration: 0s !important; } }` | XS     |
| P3f | Navigation has no "active" state indicator on current page's nav item                                    | `_includes/header.html` + `assets/css/main.css` | Add `aria-current="page"` handling for top-level nav items                                                       | XS     |
| P3g | Email capture Tally iframe lacks dark-mode awareness (transparentBackground=1 but form bg may not match) | `index.md`, stack pages                         | Ensure iframe sandbox allows proper rendering in dark mode, or use `transparentBackground` properly              | XS     |

### Summary

| Severity  | Count  |
| --------- | ------ |
| P0        | 3      |
| P1        | 6      |
| P2        | 12     |
| P3        | 7      |
| **Total** | **28** |

---

## Implementation Sprint Plan

### Sprint 1 — Foundation: Typography, Tokens, Critical Fixes

Fixes P0 issues, establishes typography scale, standardizes borders.

| #   | Issue                                                                                   | File                             | Deps | Effort |
| --- | --------------------------------------------------------------------------------------- | -------------------------------- | ---- | ------ |
| 1.1 | **P0a**: Fix blog-after-footer on homepage — move blog list rendering into content area | `_layouts/home.html`, `index.md` | None | S      |
| 1.2 | **P0b**: Suppress minima double footer on homepage                                      | `_layouts/default.html`          | None | XS     |
| 1.3 | **P0c**: Fix maintainer bio rendering as `<h2>`                                         | `index.md`                       | None | XS     |
| 1.4 | Add global typography scale: `html` base, `body` rules, H1-H3 with mobile breakpoints   | `assets/css/main.css`            | None | S      |
| 1.5 | Standardize card borders `#d1d5db` → `#e5e7eb` across all components                    | `assets/css/main.css`            | None | M      |
| 1.6 | Add `body { background: #fff }` for light mode                                          | `assets/css/main.css`            | None | XS     |
| 1.7 | Add `.problem-statement` color `#374151`                                                | `assets/css/main.css`            | None | XS     |

**Acceptance criteria:**

- [ ] Blog listing appears BEFORE footer on homepage
- [ ] Only one footer visible on homepage (no minima double footer)
- [ ] Maintainer bio renders as proper text, not `<h2>`
- [ ] Body text is 16px/1.6, H1-H3 have defined sizes with mobile breakpoints
- [ ] All card borders use `#e5e7eb` consistently
- [ ] Build passes with `make build`

### Sprint 2 — Component Styling: Cards, Code, Badges, Focus

Adds hover states, code block styling, badge components, focus rings.

| #   | Issue                                                                      | File                  | Deps | Effort |
| --- | -------------------------------------------------------------------------- | --------------------- | ---- | ------ |
| 2.1 | Add card hover states — border-color, shadow, transition                   | `assets/css/main.css` | 1.5  | S      |
| 2.2 | Add code block (`pre`, `code`) base styles with left border accent         | `assets/css/main.css` | None | S      |
| 2.3 | Add inline badge styling — `.badge--live`, `.badge--coming-soon` CSS pills | `assets/css/main.css` | None | S      |
| 2.4 | Add global `a:focus-visible` and `.cta-button:focus-visible` focus rings   | `assets/css/main.css` | None | XS     |
| 2.5 | Add `prefers-reduced-motion` override                                      | `assets/css/main.css` | None | XS     |

**Acceptance criteria:**

- [ ] Cards have green border on hover with subtle shadow
- [ ] Code blocks have #f9fafb bg, left green border, proper monospace font
- [ ] Badges are styled CSS pills instead of external img.shields.io URLs
- [ ] All interactive elements have visible focus rings
- [ ] `prefers-reduced-motion` disables transitions
- [ ] Build passes

### Sprint 3 — Navigation & Layout: Breadcrumbs, Favicon, 404, Nav Polish

Adds navigation improvements, missing infrastructure.

| #   | Issue                                                                  | File                                                       | Deps                     | Effort |
| --- | ---------------------------------------------------------------------- | ---------------------------------------------------------- | ------------------------ | ------ |
| 3.1 | Add `<link rel="icon">` for favicon                                    | `_includes/head.html` or `_layouts/default.html`           | Create or source favicon | XS     |
| 3.2 | Create custom 404 page                                                 | `404.html` (new)                                           | None                     | XS     |
| 3.3 | Add breadcrumb navigation include for learn guides and stack pages     | `_includes/breadcrumbs.html` (new) + `assets/css/main.css` | None                     | S      |
| 3.4 | Add "← Back to all guides" link in learn guide meta                    | `_includes/guide-meta.html`                                | None                     | XS     |
| 3.5 | Add nav open/close transition with opacity + transform                 | `assets/css/main.css`                                      | None                     | XS     |
| 3.6 | Add `aria-current="page"` active state styling for top-level nav items | `_includes/header.html`, `assets/css/main.css`             | None                     | S      |

**Acceptance criteria:**

- [ ] Favicon displays in browser tab
- [ ] 404 page shows helpful nav links, not GitHub Pages default
- [ ] Breadcrumbs appear on learn guides and stack pages
- [ ] Learn guides have "← Back to all guides" link
- [ ] Nav panel opens with smooth transition
- [ ] Current page nav item is visually indicated
- [ ] Build passes

### Sprint 4 — Content: Blog Expansion & DORA Mapping

Expands the founding story blog post and rewrites the DORA AI Capabilities section.

| #   | Issue                                                                        | File                                     | Deps     | Effort |
| --- | ---------------------------------------------------------------------------- | ---------------------------------------- | -------- | ------ |
| 4.1 | Expand blog post to 800–1200 words                                           | `_posts/2026-05-11-why-im-building-*.md` | None     | L      |
| 4.2 | Rewrite DORA AI Capabilities as 2-col stack-to-capability mapping with links | `index.md` + `assets/css/main.css`       | 1.5, 2.1 | M      |
| 4.3 | Remove RSS subscribe link from blog listing                                  | `_layouts/home.html`                     | None     | XS     |
| 4.4 | Add "From the blog" section heading styling for visual separation            | `assets/css/main.css`                    | None     | XS     |

**Acceptance criteria:**

- [ ] Blog post covers: problem background, solution origin story, architecture decisions, roadmap, call to action
- [ ] DORA AI Capabilities section shows which stacks enable each capability with visual badges
- [ ] No RSS subscribe link on homepage
- [ ] Blog section has visual heading with separation from content above
- [ ] Build passes

### Sprint 5 — Dark Mode Polish & Stack Page Differentiation

Audits and fixes dark mode consistency, adds per-stack visual identity.

| #   | Issue                                                                                                   | File                                          | Deps | Effort |
| --- | ------------------------------------------------------------------------------------------------------- | --------------------------------------------- | ---- | ------ |
| 5.1 | Audit all dark mode overrides for consistency — `.try-now`, `.email-capture`, `.dojo-callout`           | `assets/css/main.css`                         | 1.5  | S      |
| 5.2 | Add per-stack accent colors (Obs=blue, Pipe=purple, DORA=amber, Sec=red, DevX=indigo) for hero sections | `assets/css/main.css` + `_layouts/stack.html` | 1.4  | M      |
| 5.3 | Fix email capture Tally iframe dark mode handling                                                       | `index.md`, `_layouts/stack.html`             | None | XS     |

**Acceptance criteria:**

- [ ] All components have consistent dark mode styling
- [ ] Each stack page has a distinct accent color in the hero
- [ ] Tally iframe renders correctly in dark mode
- [ ] Build passes

### Sprint 6 — Screenshots & Trust Signals

Adds visual proof to stack pages.

| #   | Issue                                                                     | File                                                     | Deps                         | Effort |
| --- | ------------------------------------------------------------------------- | -------------------------------------------------------- | ---------------------------- | ------ |
| 6.1 | Add screenshots to stack pages (Grafana dashboard, terminal output, etc.) | `obs/index.md`, `pipe/index.md`, etc. + `assets/images/` | Needs real stack screenshots | M      |
| 6.2 | Add `.screenshot` component CSS                                           | `assets/css/main.css`                                    | None                         | XS     |

**Acceptance criteria:**

- [ ] At least Obs page has a real screenshot (Grafana dashboard or terminal output)
- [ ] Screenshots have descriptive alt text
- [ ] Images are ≤300KB each
- [ ] Build passes

---

## Design Token Audit

### Tokens defined in `pr3-plan.md` but NOT yet applied in CSS

| Token                  | Value            | Where it should be applied                                                                       |
| ---------------------- | ---------------- | ------------------------------------------------------------------------------------------------ |
| `color-text-primary`   | `#111827`        | H1-H3 currently have no explicit color — H1 is in `.hero-copy h1` via minima, H2-H3 are unhooked |
| `color-text-secondary` | `#374151`        | `.problem-statement` (line 178), body paragraphs                                                 |
| `color-text-muted`     | `#6b7280`        | `.guide-meta__read-time` (line 484 — already uses #4b5563, should be #6b7280)                    |
| `color-text-on-brand`  | `#ffffff`        | Already used in `.cta-button` (line 405)                                                         |
| `color-border`         | `#e5e7eb`        | Should replace `#d1d5db` on lines 174, 406, 433, 454, 508 — Sprint 1.5                           |
| `color-border-strong`  | `#d1d5db`        | Reserved for active/hover states, not default                                                    |
| `color-bg-subtle`      | `#f9fafb`        | Should be code block background, `.guide-meta` background (line 475 — already correct)           |
| `color-bg-hover`       | `#f3f4f6`        | Already used in `.main-nav__link:hover` (line 99)                                                |
| `text-h1`              | 36px/28px mobile | Not yet applied — H1 uses `clamp(1.6rem, 3vw, 2.4rem)` in `.hero-copy h1` (line 172)             |
| `text-h2`              | 24px/20px mobile | Not applied — H2 uses browser defaults                                                           |
| `text-h3`              | 18px             | Not applied — H3 uses browser defaults (`.stack-card h3` has `margin-top: 0` only)               |
| `text-body`            | 16px/1.6lh       | Not applied — `body` has no font-size/line-height                                                |
| `text-code`            | 14px             | Not applied — `code` has no explicit font-size                                                   |
| `radius-lg`            | 8px              | Card border-radius uses 12px — should be 8px per design tokens                                   |
| `radius-xl`            | 12px             | Currently used on cards — should be reserved for callouts only                                   |
| `space-3`              | 24px             | Card padding uses `1rem` (16px) — should be 24px desktop                                         |

### Hardcoded values that need token replacement

| Line(s)  | Current value                                                    | Should be                                           |
| -------- | ---------------------------------------------------------------- | --------------------------------------------------- |
| 99-100   | `.main-nav__link:hover { background: #f3f4f6; color: #111827; }` | token: `color-bg-hover`, `color-text-primary`       |
| 174, 184 | `border: 1px solid #d1d5db`                                      | `border: 1px solid #e5e7eb` (token: `color-border`) |
| 178      | `font-size: 1.05rem` (`.problem-statement`)                      | Should have explicit `color: #374151`               |
| 186      | `border-radius: 12px` (cards)                                    | Should be `border-radius: 8px` (token: `radius-lg`) |
| 433, 454 | `.try-now` / `.try-now__command` borders                         | Should be `#e5e7eb`                                 |
| 508      | `.dojo-callout` border                                           | Should be `#e5e7eb`                                 |
| 484      | `.guide-meta__read-time` color `#4b5563`                         | Should be `#6b7280` (token: `color-text-muted`)     |

---

## Component Library Gap Analysis

| Component               | Status     | Priority | Notes                                                                                  |
| ----------------------- | ---------- | -------- | -------------------------------------------------------------------------------------- |
| Button (primary)        | ✅ Done    | —        | `.cta-button` — needs focus ring added (Sprint 2.4)                                    |
| Button (secondary)      | ✅ Done    | —        | `.cta-button--secondary` — Sprint 3 already fixed light/dark                           |
| Hero section            | ✅ Done    | —        | `.hero-layout` + `.hero-copy`                                                          |
| Stack card              | ✅ Done    | —        | `.stack-card` — needs hover state (Sprint 2.1), border fix (Sprint 1.5), radius change |
| Capability card         | ✅ Done    | —        | `.capability-card` — needs same fixes as stack card                                    |
| Dojo callout            | ✅ Done    | —        | `.dojo-callout` — needs border fix (Sprint 1.5)                                        |
| Try-now section         | ✅ Done    | —        | `.try-now` — needs border fix (Sprint 1.5)                                             |
| Guide meta              | ✅ Done    | —        | `.guide-meta` — needs color audit on read-time                                         |
| Email capture           | ✅ Done    | —        | `.email-capture` — needs border fix (Sprint 1.5)                                       |
| Navigation              | ✅ Done    | —        | Header nav — needs transition (Sprint 3.5), active state (Sprint 3.6)                  |
| Hamburger toggle        | ✅ Done    | —        | `.nav-toggle` — Sprint 3 already fixed hit area + hover/focus                          |
| **Badge (CSS pill)**    | ❌ Missing | P2       | Sprint 2.3 — replace external img.shields.io with styled `.badge` component            |
| **Code block**          | ❌ Missing | P2       | Sprint 2.2 — `pre`/`code` base styles with left border                                 |
| **Breadcrumb**          | ❌ Missing | P2       | Sprint 3.3 — nav breadcrumbs for learn/stack pages                                     |
| **404 page**            | ❌ Missing | P1       | Sprint 3.2 — custom 404 with nav links                                                 |
| **Favicon**             | ❌ Missing | P1       | Sprint 3.1 — browser tab icon                                                          |
| **Screenshot/Image**    | ❌ Missing | P1       | Sprint 6 — stack page screenshots                                                      |
| **Alert/Note callout**  | ❌ Missing | P3       | Future — info/warning callout boxes for learn guides                                   |
| **Table**               | ❌ Missing | P3       | Future — data tables for metrics/capabilities                                          |
| **Card grid (section)** | ✅ Done    | —        | `.stack-grid`, `.capability-grid`                                                      |

---

## UX Improvements Beyond Existing Plan

### Homepage

1. **Hero text alignment**: Hero section uses 2-col grid but only has content in left column. Consider center-aligned single-column hero with full-width CTA for stronger impact — or add visual element (terminal window SVG, dashboard screenshot) to right column.
2. **Stack card CTA hierarchy**: Each stack card has `code` and GitHub link. Consider making the card title itself clickable (the stack name links to the stack page) — currently only the title text inside the card has a link, but the card visual area is not clickable.
3. **"From the blog" date prominence**: Date stamp uses minima's `post-meta` class which is small and muted. Consider a more prominent date display with a "Read more →" link for better engagement.
4. **Email capture placement**: Currently below everything. Consider moving above the footer or making it a sticky bottom bar for returning visitors.

### Stack Pages

1. **Hero section lacks visual evidence**: No screenshot, no terminal output, no diagram. The hero relies entirely on text. A visual element in the right column would dramatically improve conversion.
2. **"Compose with" is text-only**: The compose-with list at the bottom is a bullet list. Consider card-style compose links showing adjacent stacks with brief descriptions.
3. **Coming-soon stacks (Sec, DevX)**: Show only an email form. Consider adding a teaser feature list or mockup to give visitors something to evaluate. An empty page with only a form is a conversion dead end.

### Learn Guides

1. **No "guide series" navigation**: Guides list at `/learn/` shows them, but individual guides don't show which guide is 1/3, 2/3, 3/3. Add guide sequence numbering.
2. **Share links are plain text**: Share:X · LinkedIn · Email at top of each guide is unstyled. Consider styled share buttons or icons.
3. **Tally forms at bottom**: The "Get notified when new guides ship" iframe at the bottom of each guide duplicates the email capture from the homepage. Consider showing only if the referrer is not the homepage.
4. **No visual anchors**: Guides use plain markdown headings. Consider adding anchor link icons next to each heading for direct linking to sections.

### Blog

1. **Single post**: With only one blog post, the `post-list` on the homepage and `/blog/` page show a single entry. This is fine for now. Consider adding the blog excerpt to the homepage card for more context.
2. **No categories/tags**: Categories in front matter (`build-in-public, dora, observability`) are defined but not rendered anywhere. Consider adding category badges or a category filter when more posts exist.

### Navigation

1. **Stacks dropdown is read-only**: The "Stacks" title in the nav is text, not a link. Consider making it a link to `/stacks/` (or just the first stack page) for keyboard navigation.
2. **No "skip to content" link**: WCAG requires a skip-to-content link for keyboard users. Add as the first focusable element.
3. **No keyboard shortcut indicator**: No description of keyboard nav (Escape closes menu). Consider adding `title` attributes or instructions for screen readers.

### General

1. **No print styles**: Pages have no `@media print` rules. Content-heavy pages (learn guides, blog) should have print-friendly styles.
2. **No social card images**: `og:image` meta tags are not set on any page. Social shares will show no preview image.
3. **No `last-modified` dates**: Content pages don't show when they were last updated. Consider adding a "Last updated" date to learn guides and blog posts.

---

## Recommended Execution Order

1. **Sprint 1** — Fix 3 P0 issues + foundation typography and borders
2. **Sprint 2** — Component styling (cards, code, badges, focus)
3. **Sprint 3** — Navigation, breadcrumbs, favicon, 404
4. **Sprint 4** — Content (blog expansion + DORA mapping)
5. **Sprint 5** — Dark mode polish + stack differentiation
6. **Sprint 6** — Screenshots + trust signals (blocked on real screenshots)

Sprints 1-3 address all P0 and P1 issues. Sprints 4-6 address P2/P3.

---

_Last updated: 2026-06-07_
_Status: Planning complete — ready for Build agent implementation_
