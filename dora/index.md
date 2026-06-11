---
layout: stack
title: uFawkesDORA
stack_name: uFawkesDORA
stack_color: amber
description: "Implementation-ready DORA dashboards with deployment frequency, lead time, change failure rate, and MTTR views for AI delivery teams."
hero: DORA dashboards for AI delivery teams. 60 seconds to running.
coming_soon: false
summary: Implementation-ready delivery performance insights that help teams improve flow, stability, and outcomes.
repo_url: https://github.com/paruff/ufawkesdora
repo_name: paruff/ufawkesdora
features:
  - DORA dashboards with deployment, lead time, and recovery views
  - AI workflow metrics that connect delivery changes to team outcomes
  - Alerting on regressions in speed, stability, and flow efficiency
  - Jenkins integration to ingest build, release, and failure events
  - Education layer that explains how to act on the metrics
quick_start:
  - git clone https://github.com/paruff/ufawkesdora.git
  - cd ufawkesdora
  - docker compose up -d
compose_with:
  - name: uFawkesObs
    url: /obs/
    description: Combine DORA reporting with service and platform observability.
  - name: uFawkesPipe
    url: /pipe/
    description: Feed DORA dashboards with composable delivery pipeline events.
  - name: uFawkesDevX
    url: /devx/
    description: Pair metrics with guided developer workflows as DevX ships.
---

## Build in public

Read the latest updates in the [uFawkes blog]({{ '/blog/' | relative_url }}), including [why I'm building the platform engineering stack]({{ '/blog/why-im-building-the-ufawkes-open-source-platform-engineering-stack/' | relative_url }}).
