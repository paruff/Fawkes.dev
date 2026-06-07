---
name: issue-format
description: Exact format for AGENTS.md Section 8 issue rows, Section 12 handoff blocks, GitHub issue descriptions, and commit messages. Used by Planning agent to maintain consistency.
license: MIT
compatibility: opencode
---

# Issue Format — uFawkes.dev

## Section 8 issue row

```
| # | Issue description — exact and actionable | ⬜ Not started | filename — location note |
```

### Status values (copy exactly)
- `⬜ Not started`
- `🔄 In progress`
- `✅ Done`

### Rules
- One issue = one file. If a task spans two files, create two rows.
- Description must be actionable: "Replace X with Y in Z" not "Fix homepage"
- Notes must name the exact file and location
- Issue numbers are sequential — never reuse a number

### Example rows
```
| 1 | Fix double H1 — change `# uFawkes` to `<span class="sr-only">uFawkes</span>` | ✅ Done | index.md line 1 after front matter |
| 9 | Replace 5× "GitHub repo coming soon" with single consolidated notice | 🔄 In progress | index.md — Stack Family section |
| 13 | Add .skip-nav CSS to end of main.css | ⬜ Not started | assets/css/main.css — append |
```

## Section 12 handoff block

```
[ ] Current branch: feature/pr-1-trust-conversion
[ ] Last completed: #3 — Social proof removed, maintainer bio added
[ ] In progress: #4 — Badge alt text fix — stopped at: pipe/index.md not yet done
[ ] Blockers: none
[ ] Next task: Complete #4 for dora/sec/devx, then #5 Dojo callout
```

Use `[x]` for items confirmed complete. Use `[ ]` for open items.
Always include the branch name. Always include the stopped-at detail for in-progress items.

## GitHub issue description

When Planning agent creates a GitHub issue:

```
## Context
[One sentence: what page/component, what problem]

## Acceptance criteria
- [ ] Build passes (make build exits 0)
- [ ] [specific visual/content check]
- [ ] Review agent approved
- [ ] Commit on main

## File
`filename` — [exact location]

## Exact change
Find: [paste exact string]
Replace with: [paste exact replacement]

## Agent
Assign to: Build agent
Scope: fix([scope])
```

## Commit message format

```
fix(scope): description (#issue-number)
```

Valid scopes:
```
index     obs       pipe      dora
sec       devx      learn     css
nav       includes  agents    skills
infra     docs
```

Examples:
```
fix(index): remove zero-star social proof badges (#3)
fix(css): append .dojo-callout styles to main.css (#5)
fix(obs): remove screenshot placeholder text (#6)
docs(agents): mark issue #9 complete, update handoff
chore(infra): add MCP server config to opencode.json (#H)
```

One logical change per commit. No multi-file commits unless the files change atomically (e.g., adding an include + referencing it in the same layout — but this requires Planning agent approval).
