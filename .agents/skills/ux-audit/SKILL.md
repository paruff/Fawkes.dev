---
name: ux-audit
description: Protocol for auditing uFawkes.dev pages — what to check, severity ranking, output format, and persona models. Used by UX and Planning agents to produce ranked, actionable findings.
license: MIT
compatibility: opencode
---

# UX Audit Protocol — uFawkes.dev

## Pages to audit

Fetch each in order using webfetch:

| Page                 | URL                                                 | Priority             |
| -------------------- | --------------------------------------------------- | -------------------- |
| Homepage             | https://ufawkes.dev/                                | P0 — highest traffic |
| Obs stack            | https://ufawkes.dev/obs/                            | P1                   |
| Pipe stack           | https://ufawkes.dev/pipe/                           | P1                   |
| DORA stack           | https://ufawkes.dev/dora/                           | P1                   |
| Sec stack            | https://ufawkes.dev/sec/                            | P1                   |
| DevX stack           | https://ufawkes.dev/devx/                           | P1                   |
| Learn hub            | https://ufawkes.dev/learn/                          | P2                   |
| DORA Primer          | https://ufawkes.dev/learn/dora-primer.html          | P2                   |
| AI Capabilities      | https://ufawkes.dev/learn/ai-capabilities.html      | P2                   |
| Observability Primer | https://ufawkes.dev/learn/observability-primer.html | P2                   |
| Blog                 | https://ufawkes.dev/blog/                           | P3                   |

## Personas

Keep these in mind when evaluating every page:

**Builder** — Senior engineer evaluating whether to adopt the stack for their team. Asks: "Does this actually work? How long to get running? Who else uses it?" High trust threshold. Notices stub content immediately.

**Operator** — Platform engineer or SRE who already uses one stack and wants to add another. Asks: "What does this add? How does it compose?" Skips hero copy, reads quick start commands directly.

**Contributor** — Developer interested in the open source project. Asks: "Is this active? Where do I start? Is the maintainer responsive?" Checks star count, commit recency, blog post dates.

## What to check per page

### Trust signals (P0 if broken)

- [ ] No zero-star badges on repos that don't have stars yet
- [ ] No "Screenshot placeholder" text visible
- [ ] No raw Liquid syntax rendered as text (e.g. `{{ page.title }}`)
- [ ] No dead links (especially GitHub repos marked "coming soon")
- [ ] Meta description is page-specific, not the global tagline
- [ ] Commit/update recency is visible and recent

### Information hierarchy

- [ ] Page answers: Why → What → How → Proof → Next Steps (in that order)
- [ ] One clear H1 per page (no double H1)
- [ ] Heading levels are logical (no skipped levels)
- [ ] Primary CTA is visible above the fold

### Conversion

- [ ] Primary action is obvious within 3 seconds
- [ ] CTA copy is specific ("Run in 60 seconds" not "Get started")
- [ ] docker compose / quick start commands are prominent, not buried
- [ ] Email/notify form is below fold but reachable

### Content completeness

- [ ] No stub sections ("Coming soon" repeated multiple times)
- [ ] No empty headings with no body text
- [ ] All feature bullets have descriptions, not just labels
- [ ] Learn guides have read time and next-guide links

### Navigation

- [ ] Stacks dropdown works
- [ ] External links (Dojo) open in new tab
- [ ] Back/breadcrumb paths are clear on learn guides

### Cross-links

- [ ] Stack pages use trailing slash: `/obs/`
- [ ] Learn guides use `.html`: `/learn/dora-primer.html`
- [ ] No trailing-slash links to `.html` pages (will 404)

## Severity classification

| Level | Label      | Meaning                              | Action                   |
| ----- | ---------- | ------------------------------------ | ------------------------ |
| P0    | Broken     | Actively damages visitor trust       | Fix before anything else |
| P1    | Conversion | Blocks primary visitor action        | Fix this sprint          |
| P2    | Quality    | Weakens credibility or comprehension | Fix next sprint          |
| P3    | Polish     | Minor improvement                    | Deferred                 |

## Output format

For each page audited, produce:

```
## Audit: [Page name] — [URL]
Audited: [date]

### P0 Broken
- [finding] → suggested fix → file: [filename]

### P1 Conversion
- [finding] → suggested fix → file: [filename]

### P2 Quality
- [finding] → suggested fix → file: [filename]

### P3 Polish
- [finding] → suggested fix → file: [filename]

### Summary
P0: N | P1: N | P2: N | P3: N
Recommended next: [issue description for Planning agent]
```

## Issue row format for Planning agent

After audit, produce rows in this format for AGENTS.md Section 8:

```
| # | [Page]: [issue description — specific and actionable] | ⬜ Not started | [filename] — [location note] |
```
