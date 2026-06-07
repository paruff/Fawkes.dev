# uFawkes.dev — Plan

> Project identity, stack, and conventions: see `AGENTS.md`
> Current branch: `main`

---

## Issue status tracker

### PR 1 — Trust & conversion (index.md)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| 1 | Fix double H1 — change `# uFawkes` to `<span class="sr-only">uFawkes</span>` | ✅ Done | index.md line 1 after front matter |
| 2 | Move email form below fold; add `## Try it now` docker compose CTA above Stack Family | ✅ Done | index.md structural reorder |
| 3 | Remove `## Social proof` zero-star badges; replace with maintainer bio line | ✅ Done | index.md |
| 4 | Fix raw badge alt text in Stack Family headings | ✅ Done | index.md — replace with plain `/obs/` paths |
| 5 | Add Fawkes Dojo callout div between Stack Family and DORA AI Capabilities | ✅ Done | index.md + assets/css/main.css |
| 9 | Replace 5× "GitHub repo coming soon" with single consolidated notice + notify link | ✅ Done | index.md — Stack Family section |
| 10 | Add visible primary CTA button above the fold ("See the stacks ↓") | ✅ Done | index.md + assets/css/main.css |
| 11 | Rename "Posts" section → "From the blog" | ✅ Done | index.md |
| 12 | DORA AI Capabilities — add one-sentence description to each of 7 items | ✅ Done | index.md |

### PR 2 — Content quality (stack pages + learn guides)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| 6 | Remove `## Screenshot placeholder` text from all five stack pages | ✅ Done | obs/ pipe/ dora/ sec/ devx/ index.md — one file per commit |
| 7 | Add `read_time` + `next_guide_url/title` to learn guides; create `_includes/guide-meta.html`; fix cross-link URL patterns | ✅ Done | learn/*.html + new include |
| 8 | Fix per-page `description` meta on all stack pages (currently shows global tagline) | ✅ Done | obs/ pipe/ dora/ sec/ devx/ front matter |

### PR 3 — Design system (FDS bootstrap — see `pr3-plan.md` for detailed sprint breakdown)

| # | Issue | Status | Notes |
|---|-------|--------|-------|
| A | Minimal design system: type scale, spacing, code block styles, focus states | ⬜ Deferred | Sprint 1–2 |
| B | Rewrite DORA AI Capabilities as 2-col stack-to-capability mapping with links | ⬜ Deferred | Sprint 3.5 |
| C | Expand founding blog post to 800–1200 words | ⬜ Deferred | Sprint 4 |
| S1 | Sprint 3: Fix broken dark-mode nesting, add cta-button--secondary light mode, dojo-callout dark mode, guide-meta dark link | ✅ Done | assets/css/main.css |
| S2 | Sprint 3: Fix DORA badge from live→coming-soon | ✅ Done | dora/index.md |
| S3 | Sprint 3: Navigation redesign — larger hit area, hover/focus states | ✅ Done | assets/css/main.css

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

## Handoff

```
[ ] Current branch: main
[ ] Last completed: Sprint 3 — Dark mode fixes, nav redesign, DORA badge
[ ] In progress: none
[ ] Blockers: none
[ ] Next task: Sprint 1 — Foundation: tokens, typography, border standardization
```

---

*Last updated: 2026-06-06*
