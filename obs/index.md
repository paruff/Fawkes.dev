---
layout: stack
title: uFawkesObs
stack_name: uFawkesObs
stack_color: blue
description: "Deploy Prometheus + Grafana observability in 60 seconds. DORA dashboards, AI metrics, and Jenkins integration for AI-enabled delivery teams."
hero: Prometheus + Grafana + AI observability. 60 seconds to running.
summary: Operational telemetry, DORA context, and AI delivery visibility in one starter stack.
repo_url: https://github.com/paruff/ufawkesobs
repo_name: paruff/ufawkesobs
features:
  - DORA dashboards wired to delivery and reliability signals
  - AI metrics for copilots, agents, and assisted workflows
  - Alerting defaults for platform health and release flow
  - Jenkins integration for CI telemetry and deployment traces
  - Education layer that explains what the signals mean
quick_start:
  - git clone https://github.com/paruff/ufawkesobs.git
  - cd ufawkesobs
  - docker compose up -d
compose_with:
  - name: uFawkesPipe
    url: /pipe/
    description: Add CI/CD orchestration and release controls around your telemetry.
  - name: uFawkesDORA
    url: /dora/
    description: Turn observability signals into implementation-ready DORA insights.
  - name: uFawkesSec
    url: /sec/
    description: Layer in secure-by-default checks as the security stack ships.
---

## Build in public

Follow stack progress in the [uFawkes blog]({{ '/blog/' | relative_url }}), starting with [the founding story]({{ '/blog/why-im-building-the-ufawkes-open-source-platform-engineering-stack/' | relative_url }}).
