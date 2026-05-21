---
layout: page
title: DORA Primer for AI Delivery Teams
description: Learn the four DORA metrics, common failure modes, and an action plan for improving delivery performance with AI-enabled teams.
og_title: DORA Primer for AI Delivery Teams
og_description: A practical DORA primer with metric definitions, targets, and next actions.
og_type: article
---

DORA gives teams a shared language for delivery performance. In AI-assisted development, that matters even more: faster coding only helps when the platform keeps quality and flow stable.

{% assign share_url = page.url | absolute_url %}
Share: [X](https://twitter.com/intent/tweet?text={{ page.title | uri_escape }}&url={{ share_url | uri_escape }}) · [LinkedIn](https://www.linkedin.com/sharing/share-offsite/?url={{ share_url | uri_escape }}) · [Email](mailto:?subject={{ page.title | uri_escape }}&body={{ share_url | uri_escape }})

## The four DORA metrics

1. **Deployment frequency** — how often you ship to production.
2. **Lead time for changes** — commit to production elapsed time.
3. **Change failure rate** — percent of deployments causing incidents, rollbacks, or hotfixes.
4. **Mean time to restore (MTTR)** — how quickly service recovers after failure.

Together these show both speed and stability. Optimize all four; over-optimizing one metric usually creates hidden drag elsewhere.

## What good looks like

- Frequent, small deployments instead of risky batch releases.
- Predictable lead time with fewer queue bottlenecks.
- Low failure rate through tests, policy checks, and safe rollout patterns.
- Fast recovery through clear alerts, runbooks, and ownership.

## AI-specific anti-patterns

- **More code, same platform**: AI output increases PR volume without improving CI/CD and observability.
- **Local speed, global slowdown**: developers move faster but release approvals and incident handling become chokepoints.
- **Metric theater**: tracking output (lines, prompts, PR count) instead of outcome (DORA).

## 30-day improvement loop

1. Baseline the four metrics weekly.
2. Pick one bottleneck (for example, review wait time).
3. Ship one platform change (automation, guardrail, or dashboard).
4. Compare DORA movement after two release cycles.

For capability planning, continue with the [AI capabilities guide]({{ '/learn/ai-capabilities/' | relative_url }}). For signal quality and instrumentation, read the [observability primer]({{ '/learn/observability-primer/' | relative_url }}).

Run this yourself: GitHub repo coming soon

## Get notified when new guides ship

<iframe
  src="https://tally.so/embed/wQ6aZ6?alignLeft=1&hideTitle=1&transparentBackground=1"
  title="Get notified when new guides ship"
  width="100%"
  height="290"
  loading="lazy"
  sandbox="allow-forms allow-scripts"
  referrerpolicy="no-referrer"
></iframe>
