---
name: planning-workflow
description: Prioritization framework, sprint sequencing, and success criteria for uFawkes.dev work. Used by Planning agent to sequence issues across PRs and agents.
license: MIT
compatibility: opencode
---

# Planning Workflow

## Prioritization framework

### P0 — Broken (fix immediately, before any other work)
Trust-damaging content that is live on the site right now.
Examples: zero-star badges, "Screenshot placeholder" text, raw Liquid rendering as text.

### P1 — Conversion (fix this sprint)
Blocks the primary visitor action. A Builder or Operator cannot complete their journey.
Examples: no CTA above fold, buried quick start, broken cross-links.

### P2 — Quality (fix next sprint)
Weakens credibility or comprehension. Visitor can still act but leaves with less confidence.
Examples: generic meta descriptions, stub content, repeated "coming soon" notices.

### P3 — Polish (deferred)
Minor improvements. No visitor impact, just cleaner.
Examples: section label tweaks, formatting consistency.

## Sprint structure

**Sprint 1 — PR 1** (all P0 and P1 issues in index.md)
Sequence: #1 → #3 → #4 → #9 → #2 → #10 → #5 → #11 → #12

Rationale: fix trust-damaging first (#1 double H1, #3 fake badges, #4 bad alt text), then consolidate notices (#9), then conversion (#2 CTA reorder, #10 hero CTA), then polish (#5 Dojo callout, #11 label, #12 DORA descriptions).

**Sprint 2 — PR 2** (stack pages and learn guides)
Sequence: #6 (all 5 stack pages) → #8 (all 5 meta descriptions) → #7 (learn guides + guide-meta include)

**Sprint 3 — PR 3** (design system — deferred)
Do not start until PR 1 and PR 2 are merged and live.

**Sprint 4 — PR 4** (agent/skill infrastructure)
Can run in parallel with Sprint 2. No site file conflicts.

## Success criteria per issue

An issue is ✅ Done when:
1. Build passes (`make build` exits 0)
2. Review agent has approved
3. Commit is on `main` (merged)
4. Planning agent has updated Section 8 status
5. Live site reflects the change (within GitHub Pages deploy time, ~2 min)

## AGENTS.md update checklist

After each issue completes:
- [ ] Change `⬜ Not started` → `✅ Done` in Section 8
- [ ] Update Section 12 handoff block
- [ ] Commit: `docs(agents): mark issue #N complete`

After each PR merges:
- [ ] Verify all issues in the PR are marked ✅
- [ ] Update Section 12 to show next sprint starting
