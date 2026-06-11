---
layout: stack
title: uFawkesSec
stack_name: uFawkesSec
stack_color: red
description: "Secure-by-default guardrails, policy-as-code, and supply chain security for platform engineering teams."
hero: Secure-by-default guardrails for AI delivery teams.
summary: Policy-as-code, safety rails, and supply chain integrity for high-speed shipping teams.
coming_soon: false
repo_url: https://github.com/paruff/ufawkessec
repo_name: paruff/ufawkessec
features:
  - Policy-as-code with OPA/Rego for automated compliance
  - Supply chain scanning and SLSA attestation
  - Admission control for Kubernetes workloads
  - Shift-left security in CI/CD pipelines
  - Education layer for security best practices
quick_start:
  - git clone https://github.com/paruff/ufawkessec.git
  - cd ufawkessec
  - docker compose up -d
compose_with:
  - name: uFawkesObs
    url: /obs/
    description: Observe security events and compliance posture across your platform.
  - name: uFawkesPipe
    url: /pipe/
    description: Embed security scanning into your delivery pipeline.
  - name: uFawkesDORA
    url: /dora/
    description: Track security metrics alongside delivery performance.
---
