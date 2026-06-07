---
layout: stack
title: uFawkesPipe
stack_name: uFawkesPipe
stack_color: purple
description: "Composable CI/CD pipelines with fast feedback and resilient release controls. Docker Compose setup in 60 seconds."
hero: Composable CI/CD pipelines with fast feedback. 60 seconds to running.
summary: Golden-path delivery automation for teams that need resilient releases without heavyweight platform work.
repo_url: https://github.com/paruff/ufawkespipe
repo_name: paruff/ufawkespipe
features:
  - Opinionated pipeline templates for fast feedback loops
  - Delivery metrics hooks that feed DORA reporting
  - Release controls for safer deploys and rollbacks
  - Jenkins integration for existing controller and agent fleets
  - Education layer to help teams adopt delivery best practices
quick_start:
  - git clone https://github.com/paruff/ufawkespipe.git
  - cd ufawkespipe
  - docker compose up -d
compose_with:
  - name: uFawkesObs
    url: /obs/
    description: Observe every pipeline run, deploy, and service health signal.
  - name: uFawkesDORA
    url: /dora/
    description: Turn pipeline events into continuous delivery performance insights.
  - name: uFawkesDevX
    url: /devx/
    description: Extend the stack with guided golden paths as DevX ships.
---
