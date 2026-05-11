---
layout: stack
title: uFawkesObs
stack_name: uFawkesObs
hero: Prometheus + Grafana + AI observability. 60 seconds to running.
summary: Operational telemetry, DORA context, and AI delivery visibility in one starter stack.
repo_name: paruff/ufawkes-obs
repo_url: https://github.com/paruff/ufawkes-obs
screenshot_placeholder: Add real screenshot after the stack is running.
features:
  - DORA dashboards wired to delivery and reliability signals
  - AI metrics for copilots, agents, and assisted workflows
  - Alerting defaults for platform health and release flow
  - Jenkins integration for CI telemetry and deployment traces
  - Education layer that explains what the signals mean
quick_start:
  - git clone https://github.com/paruff/ufawkes-obs.git
  - cd ufawkes-obs
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
