---
name: cross-agent-coordination
description: Handoff protocol, dependency sequencing, and parallel task rules for the uFawkes agent team. Ensures agents don't conflict, block each other, or duplicate work.
license: MIT
compatibility: opencode
---

# Cross-Agent Coordination

## Agent responsibility matrix

| Task type        | Responsible   | Reviews | Approves |
| ---------------- | ------------- | ------- | -------- |
| UX audit finding | UX            | —       | Planning |
| Visual spec      | UI            | UX      | Planning |
| Token definition | Design-System | UI      | Planning |
| Implementation   | Build         | Review  | Planning |
| Build failure    | Build         | Infra   | —        |
| AGENTS.md update | Planning      | —       | —        |
| Deployment issue | Infra         | —       | Planning |

## Handoff protocol

Every agent handoff must include:

```
From: [agent name]
To: [agent name]
Task: [issue number + description]
Input: [what I'm handing you]
Constraint: [any blocking dependency]
Acceptance: [how you know it's done]
```

## Sequencing rules

1. **Never start Build without a reviewed spec** — UX → UI → Build, in order
2. **One file per Build task** — if a task touches two files, split before assigning
3. **Review before every commit** — Build proposes, Review approves, Build commits
4. **Planning updates AGENTS.md last** — after Review approves, not before

## Parallel task rules

Agents can work in parallel when:

- Tasks are in different files (e.g., Build on index.md, UI speccing obs/index.md)
- Tasks have no shared dependency (e.g., Infra fixing CNAME, Build fixing CSS)

Agents must NOT work in parallel when:

- Both touch `assets/css/main.css` (append-only — sequential only)
- Both touch `AGENTS.md`
- A downstream agent depends on the upstream agent's output

## Conflict resolution

If two agents produce conflicting outputs:

1. Planning agent is the tiebreaker
2. Jekyll constraints (Section 2 of AGENTS.md) override all agent preferences
3. Accessibility requirements override visual preferences
4. P0 issues override all other work

## Communication format

When reporting to Planning agent:

```
Status: [completed|blocked|in-progress]
Issue: #N
File: [filename]
Build: [pass|fail]
Finding: [one sentence]
Next: [what Planning should assign next]
```
