---
name: content-strategy
description: Content strategy for uFawkes.dev — narrative structure, page-level content hierarchy, tone guidelines, CTA copy patterns, and trust signal rules.
license: MIT
compatibility: opencode
---

# Content Strategy — uFawkes.dev

## Narrative framework

Every page follows this structure — in this order:

```
Why     → What problem does this solve? (1–2 sentences max)
What    → What is this, specifically? (name, category, key feature)
How     → How do I get it running? (quick start, docker compose)
Proof   → Why should I trust it? (real metrics, real examples, honest status)
Next    → What do I do after this? (compose with, learn more, contribute)
```

Visitors skim. If "How" is buried under three paragraphs of "Why", builders drop off.

## Tone guidelines

| Do                            | Don't                                  |
| ----------------------------- | -------------------------------------- |
| Direct and specific           | Vague and promotional                  |
| "60 seconds to running"       | "Get started today"                    |
| "Prometheus + Grafana + AI"   | "Powerful observability solution"      |
| "Repos launching soon" (once) | "GitHub repo coming soon" (five times) |
| "Built by @paruff"            | "Enterprise-grade"                     |
| Honest about early status     | Fake social proof (zero-star badges)   |

Voice: confident engineer talking to engineers. Not a sales page. Not a startup pitch deck.

## Homepage content structure

```
[ H1: hidden sr-only "uFawkes" ]
[ Hero: "Production platform engineering, open source." ]
[ Subhead: 2 sentences — what it is and why it exists ]
[ Primary CTA: "See the stacks ↓" — scrolls to stack family ]
[ Stack Family: 5 cards — emoji, name, one-line hero, quick start ]
[ Dojo callout: "Practice in the Dojo →" ]
[ DORA AI Capabilities: 2-col table with descriptions ]
[ From the blog: 1 latest post card ]
[ Email form: "Get notified when stacks launch" ]
```

## Stack page content structure

```
[ Hero: stack name + one-line hero ]
[ Quick start: 3 docker compose commands ]
[ Features: 4–6 bullet points with real descriptions ]
[ Compose with: links to related stacks ]
[ Get notified / GitHub link ]
```

## CTA copy patterns

| Context           | Good copy                    | Bad copy      |
| ----------------- | ---------------------------- | ------------- |
| Primary homepage  | "See the stacks ↓"           | "Get started" |
| Stack quick start | "Run in 60 seconds"          | "Try it now"  |
| Coming soon       | "Notify me when it launches" | "Coming soon" |
| Learn hub         | "Read the DORA primer →"     | "Learn more"  |
| Dojo              | "Practice in the Dojo →"     | "Click here"  |
| Contribute        | "View on GitHub →"           | "GitHub"      |

## Trust signal rules

**Real trust signals (use these):**

- Honest "repos launching soon" with a notify form
- Maintainer bio with real GitHub profile
- Blog post with a real date showing active development
- Docker compose commands that actually work

**Anti-trust signals (remove these):**

- Zero-star GitHub badges
- "Screenshot placeholder" text
- "GitHub repo coming soon" repeated 5 times
- Generic meta descriptions (shows the global tagline)
- Empty feature sections

## Meta description rules

Each page must have a unique `description` in front matter:

| Page        | Description pattern                                                                                                                 |
| ----------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Homepage    | "uFawkes — open source platform engineering stacks. Prometheus, Grafana, DORA metrics, and AI capabilities. 60 seconds to running." |
| Stack page  | "[StackName] — [what it is] for [who]. [key differentiator]."                                                                       |
| Learn guide | "[Topic] explained for platform engineers. [what you'll learn]."                                                                    |
| Blog post   | Use the `excerpt` field                                                                                                             |

Never use the global tagline as a page description.
