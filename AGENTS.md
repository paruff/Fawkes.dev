# uFawkes.dev — Universal Agentic Handoff Prompt

> Paste this entire document at the start of any new session with Claude Code,
> OpenCode, GitHub Copilot Coding Agent, Gemini CLI, Cursor, or any other
> agentic coding tool. It gives the agent complete, verified context to
> continue work without re-reading the whole repo.

---

## 1. Project identity

| Key | Value |
|-----|-------|
| Site | https://ufawkes.dev |
| Repo | https://github.com/paruff/uFawkes.dev |
| Branch model | `main` is prod — every merge auto-deploys via GitHub Pages |
| Maintainer | @paruff (Phil Ruff) |
| Purpose | Public marketing + education site for the uFawkes open-source platform engineering ecosystem |

---

## 2. Tech stack (hard constraints — do not deviate)

```
Generator : Jekyll 4.4.1 (GitHub Pages whitelist)
Theme     : minima (overridden via _layouts/, _includes/)
Plugins   : jekyll-feed only — NO others
CSS       : Vanilla CSS in assets/css/main.css (BEM naming, append-only)
JS        : Vanilla JS only — assets/js/nav.js — NO npm/webpack/bundler
Templating: Liquid (Jekyll-flavored) — whitelisted filters only
Deployment: GitHub Pages from main root — no build step needed locally
Commands  : make serve  →  bundle exec jekyll serve --livereload
            make build  →  bundle exec jekyll build
```

**Never introduce:** npm, webpack, Vite, Tailwind, SCSS, CSS custom properties,
React, Astro, Vue, Jekyll plugins not on the GitHub Pages whitelist, or any
server-side logic.

---

## 2b. Agent roster & tool configuration

### Architecture decision

Custom agents and reusable skills live at `~/.config/opencode/` (global),
not in this repo. This makes them reusable across all uFawkes repos
(ufawkes-obs, ufawkes-pipe, etc.). Only project-specific permission overrides
and MCP config live in `.opencode/opencode.json`.

Run `./consolidate-agents.sh --dry-run` to preview the migration.
Run `./consolidate-agents.sh` to execute it.

### Primary agents (Tab to switch in OpenCode)

| Agent | Mode | Purpose |
|-------|------|---------|
| build (built-in) | primary | Default — full file + bash access |
| plan (built-in) | primary | Analysis only — no edits |

### Custom subagents (@ mention)

| Agent | File | Purpose | Key permissions |
|-------|------|---------|-----------------|
| ux | `~/.config/opencode/agents/ux.md` | Audit live pages, define IA, wireframes, content strategy | webfetch: allow, edit: deny |
| ui | `~/.config/opencode/agents/ui.md` | Visual specs — typography, layout, component styling | read: allow, edit: deny |
| design-system | `~/.config/opencode/agents/design-system.md` | Token definitions, pattern library, DS compliance | read: allow, edit: deny |
| planning | `~/.config/opencode/agents/planning.md` | Prioritize issues, update AGENTS.md Sections 8+12 | edit: AGENTS.md only |
| review | `~/.config/opencode/agents/review.md` | Validate builds — read-only, no edits | bash: make build only |
| build | `~/.config/opencode/agents/build.md` | Implement Jekyll/CSS/Liquid changes — one file per task | edit: allow, bash: make build |
| infra | `~/.config/opencode/agents/infra.md` | GitHub Pages, _config.yml, Gemfile, opencode.json | bash: allow |

### Skills (auto-discovered — no linking required)

Skills live at `~/.config/opencode/skills/`. Agents load them on demand.
Permission overrides in `.opencode/opencode.json` (tailwind-tokens: deny, astro-components: deny).

| Skill | Used by | Purpose |
|-------|---------|---------|
| `jekyll-site-conventions` | ALL agents | Hard constraints: stack, plugins, CSS rules, Liquid safety, commit format |
| `ux-audit` | ux, planning | Audit protocol: what to check, severity ranking (P0–P3), output format |
| `accessibility-workflow` | ux, ui, review | Three-phase: audit → remediate → verify. WCAG AA rules + CSS patterns |
| `visual-design` | ui, design-system | Typography scale, spacing rhythm, color tokens, component visual rules |
| `component-workflow` | ui, build | Component anatomy → spec → Jekyll/Liquid integration patterns |
| `responsive-layout` | ui, build | Canonical breakpoints (767px/640px), grid patterns, touch targets |
| `design-system-workflow` | design-system | Token lifecycle, pattern library, compliance checking. PR 3 deferred |
| `content-strategy` | ux, planning | Narrative framework (Why→What→How→Proof→Next), tone, CTA copy, trust signals |
| `cross-agent-coordination` | planning, all | Handoff protocol, dependency sequencing, parallel task rules |
| `planning-workflow` | planning | P0–P3 prioritization, sprint sequencing, success criteria |
| `code-quality` | review, build | Liquid/HTML/CSS linting rules, build quality gates |
| `issue-format` | planning | Section 8 table format, Section 12 handoff, GitHub issue template, commit format |

### Consolidated from 29 → 12 skills

The original 29 skills were too granular and two conflicted with the Jekyll stack.
See `.opencode-skill-audit.log` after running `consolidate-agents.sh` for the
full old→new mapping.

Deleted: `tailwind-tokens` (contradicts vanilla CSS), `astro-components`
(contradicts Jekyll).

### MCP servers (configured in `.opencode/opencode.json`)

| Server | URL | Purpose |
|--------|-----|---------|
| GitHub MCP | `https://api.githubcopilot.com/mcp/` | Planning agent reads/creates GitHub issues |
| Playwright MCP | `npx @playwright/mcp@latest --headless` | UX agent takes screenshots of live site |

### Recommended workflow per issue

```
1. @ux        → audit relevant live page → ranked findings (P0–P3)
2. plan       → read findings → propose exact file + line changes
3. @review    → confirm no constraint violations before edit
4. build      → implement ONE file → run make build → report
5. @review    → approve or block with exact finding
6. build      → commit: fix(scope): description (#N)
7. @planning  → mark ✅ in Section 8, update Section 12
```

---

## 3. Repo structure (canonical)

```
uFawkes.dev/
├── AGENTS.md                    ← this file
├── consolidate-agents.sh        ← migration script
├── .opencode/
│   └── opencode.json            ← permissions + MCP config (project-specific)
├── _config.yml
├── _data/
│   ├── navigation.yml
│   └── maintainer.yml
├── _includes/
│   ├── header.html
│   └── guide-meta.html          ← planned (issue #7)
├── _layouts/
│   ├── default.html
│   ├── home.html
│   ├── post.html
│   └── stack.html
├── _posts/
│   └── 2026-05-11-why-im-building-*.md
├── assets/
│   ├── css/main.css             ← ALL styles — single file, append-only
│   └── js/nav.js
├── blog/index.md
├── {obs,pipe,dora,sec,devx}/index.md
├── learn/
│   ├── index.md
│   ├── dora-primer.html
│   ├── ai-capabilities.html
│   └── observability-primer.html
├── index.md
├── CNAME                        ← ufawkes.dev
├── Gemfile
└── Makefile

Global (not in this repo):
~/.config/opencode/
├── agents/
│   ├── ux.md
│   ├── ui.md
│   ├── design-system.md
│   ├── planning.md
│   ├── review.md
│   ├── build.md
│   └── infra.md
└── skills/
    ├── jekyll-site-conventions/SKILL.md
    ├── ux-audit/SKILL.md
    ├── accessibility-workflow/SKILL.md
    ├── visual-design/SKILL.md
    ├── component-workflow/SKILL.md
    ├── responsive-layout/SKILL.md
    ├── design-system-workflow/SKILL.md
    ├── content-strategy/SKILL.md
    ├── cross-agent-coordination/SKILL.md
    ├── planning-workflow/SKILL.md
    ├── code-quality/SKILL.md
    └── issue-format/SKILL.md
```

---

## 4. Front matter conventions

### General pages
```yaml
---
layout: default
title: Page Title
description: "Page-specific meta — NOT the global tagline"
permalink: /path/
---
```

### Stack pages
```yaml
---
layout: stack
title: uFawkesObs
stack_name: Obs
hero: "Prometheus + Grafana + AI observability. 60 seconds to running."
summary: "One-line summary for cards"
coming_soon: false
repo_url: https://github.com/paruff/ufawkes-obs
repo_name: ufawkes-obs
screenshot_placeholder: false
features:
  - DORA dashboards wired to delivery signals
quick_start:
  - step: git clone https://github.com/paruff/ufawkes-obs.git
  - step: cd ufawkes-obs
  - step: docker compose up -d
compose_with:
  - url: /pipe/
    name: uFawkesPipe
    description: Add CI/CD orchestration
---
```

### Blog posts
```yaml
---
layout: post
title: "Post title"
date: YYYY-MM-DD
permalink: /blog/slug/
excerpt: "One-sentence excerpt."
---
```

### Learn guides (.html extension, not .md)
```yaml
---
layout: default
title: "Guide Title"
description: "Guide-specific meta description"
read_time: 5
next_guide_url: /learn/next-guide.html
next_guide_title: Next Guide Title
---
```

---

## 5. Liquid rules

- Internal links in templates: `{{ '/obs/' | relative_url }}`
- Internal links in markdown: plain `/obs/`
- Pages: trailing slash. Learn guides: `.html` extension
- External links: `rel="noopener noreferrer" target="_blank"`
- Allowed filters: `relative_url`, `absolute_url`, `url_encode`, `date`, `markdownify`, `strip_html`, `truncate`, `slugify`
- Never: `{% unless %}`, `{% case %}`, multi-variable assign chains
- Always verify included files exist before referencing

---

## 6. CSS conventions

- Single file: `assets/css/main.css` — **append only, never reorder**
- BEM: `.block`, `.block__element`, `.block--modifier`
- Breakpoints: `767px` (tablet), `640px` (mobile) — canonical, never invent others
- Brand green: `#16a34a` | Text primary: `#111827` | Border: `#e5e7eb` | Bg subtle: `#f9fafb`
- Spacing: multiples of 8px
- No CSS variables — hex values directly until design-system token migration

---

## 7. Navigation structure

```yaml
- title: Stacks
  dropdown: true
  items:
    - title: "👁️ Obs"
      url: /obs/
    - title: "🔁 Pipe"
      url: /pipe/
    - title: "📈 DORA"
      url: /dora/
    - title: "🛡️ Sec"
      url: /sec/
    - title: "🧭 DevX"
      url: /devx/
- title: Learn
  url: /learn/
- title: Blog
  url: /blog/
- title: "🟢 Dojo"
  url: https://paruff.github.io/fawkes/dojo/
  external: true
```

---

## 8. Issue status tracker

### PR 1 — Trust & conversion (index.md)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| 1 | Fix double H1 — change `# uFawkes` to `<span class="sr-only">uFawkes</span>` | ⬜ Not started | index.md line 1 after front matter |
| 2 | Move email form below fold; add `## Try it now` docker compose CTA above Stack Family | ⬜ Not started | index.md structural reorder |
| 3 | Remove `## Social proof` zero-star badges; replace with maintainer bio line | ⬜ Not started | index.md |
| 4 | Fix raw badge alt text in Stack Family headings | ⬜ Not started | index.md — replace with plain `/obs/` paths |
| 5 | Add Fawkes Dojo callout div between Stack Family and DORA AI Capabilities | ⬜ Not started | index.md + assets/css/main.css |
| 9 | Replace 5× "GitHub repo coming soon" with single consolidated notice + notify link | ⬜ Not started | index.md — Stack Family section |
| 10 | Add visible primary CTA button above the fold ("See the stacks ↓") | ⬜ Not started | index.md + assets/css/main.css |
| 11 | Rename "Posts" section → "From the blog" | ⬜ Not started | index.md |
| 12 | DORA AI Capabilities — add one-sentence description to each of 7 items | ⬜ Not started | index.md |

### PR 2 — Content quality (stack pages + learn guides)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| 6 | Remove `## Screenshot placeholder` text from all five stack pages | ⬜ Not started | obs/ pipe/ dora/ sec/ devx/ index.md — one file per commit |
| 7 | Add `read_time` + `next_guide_url/title` to learn guides; create `_includes/guide-meta.html`; fix cross-link URL patterns | ⬜ Not started | learn/*.html + new include |
| 8 | Fix per-page `description` meta on all stack pages (currently shows global tagline) | ⬜ Not started | obs/ pipe/ dora/ sec/ devx/ front matter |

### PR 3 — Design system (deferred — do not start until PR 1+2 merged)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| A | Minimal design system: type scale, spacing, code block styles, focus states | ⬜ Deferred | assets/css/main.css ~80 lines |
| B | Rewrite DORA AI Capabilities as 2-col stack-to-capability mapping with links | ⬜ Deferred | index.md |
| C | Expand founding blog post to 800–1200 words | ⬜ Deferred | Content task — not code |

### PR 4 — Agent & skill infrastructure (can run parallel to PR 2)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| D | Run consolidate-agents.sh — migrate agents to ~/.config/opencode/agents/ | ⬜ Not started | Repo root → run script |
| E | Install 12 consolidated skills to ~/.config/opencode/skills/ | ⬜ Not started | Run script — verify report |
| F | Verify opencode.json written correctly — deny tailwind-tokens + astro-components | ⬜ Not started | .opencode/opencode.json |
| G | Delete old .opencode/agents/ and .opencode/skills/ after verification | ⬜ Not started | Only after D+E confirmed working |
| H | Add playwright MCP — test UX agent screenshot of live site | ⬜ Not started | Requires Node + npx |
| I | Add GitHub MCP — test planning agent creating a test issue | ⬜ Not started | Requires GitHub Copilot subscription |

---

## 9. Agentic working rules

### Per-task discipline
- **One file per task** — never combine edits to multiple files in one instruction
- **Verify before staging** — run `make build` after every file change
- **Exact text matching** — quote the exact string to find including whitespace
- **Await review** — Build agent proposes; Review agent approves; Build commits

### Liquid safety
- Never add `{% unless %}`, `{% case %}`, or multi-variable assign chains
- Verify included files exist before referencing
- Run `make build` after any Liquid change; confirm output is not empty

### CSS safety
- Append only — never reorder or restructure `main.css`
- One blank line between rule blocks
- Run `make build` and visually check affected pages after appending

### Front matter safety
- Preserve ALL existing front matter keys on any page you edit
- Only add new keys — never remove unless explicitly instructed AND verified unused

### Commit format
```
fix(scope): description (#issue-number)
```
Valid scopes: `index` `obs` `pipe` `dora` `sec` `devx` `learn` `css` `nav` `includes` `agents` `skills` `infra` `docs`

---

## 10. Agent launch commands

### OpenCode (recommended)
```bash
opencode                                    # launch TUI
Tab                                         # switch Build ↔ Plan
@ux "audit https://ufawkes.dev/obs/"        # invoke UX subagent
@planning "update Section 8 and 12"        # invoke planning subagent
@review "check issue #6 obs/index.md"      # invoke review subagent
```

### Claude Code
```bash
claude --model claude-sonnet-4-6
# /model to switch interactively
```

### GitHub Copilot Coding Agent
Governed by `.copilotinstructions.md`. Assign GitHub issues directly from the Issues UI.

### Gemini CLI
```bash
gemini
# /read AGENTS.md then paste task
```

---

## 11. Key URLs

| Page | URL |
|------|-----|
| Homepage | https://ufawkes.dev |
| Obs | https://ufawkes.dev/obs/ |
| Pipe | https://ufawkes.dev/pipe/ |
| DORA | https://ufawkes.dev/dora/ |
| Sec | https://ufawkes.dev/sec/ |
| DevX | https://ufawkes.dev/devx/ |
| Learn hub | https://ufawkes.dev/learn/ |
| DORA Primer | https://ufawkes.dev/learn/dora-primer.html |
| AI Capabilities | https://ufawkes.dev/learn/ai-capabilities.html |
| Observability Primer | https://ufawkes.dev/learn/observability-primer.html |
| Blog | https://ufawkes.dev/blog/ |
| Fawkes Dojo | https://paruff.github.io/fawkes/dojo/ |
| GitHub Sponsors | https://github.com/sponsors/paruff |
| Email form (Tally) | https://tally.so/embed/ODbbpR |

---

## 12. What to do next

```
[ ] Current branch: ___
[ ] Last completed: #___ — ___
[ ] In progress: #___ — ___ — stopped at: ___
[ ] Blockers: ___
[ ] Next task: ___
```

---

*Last updated: 2026-06-06*
*Update Sections 8 and 12 before every handoff.*
