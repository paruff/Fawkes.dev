# .pipeline.yml Schema Reference

> Configuration file for the uFawkes Canonical CI Pipeline.
> Each repository has a `.pipeline.yml` at its root that defines which stages run.

## Version

```yaml
version: "1" # Required. Currently only version 1 is supported.
```

## Repo Type

```yaml
repo-type: stack # Required. Options: core | stack | template | site | bootstrap
```

| Type        | Description                          | Example                                    |
| ----------- | ------------------------------------ | ------------------------------------------ |
| `core`      | Full IDP monorepo with all languages | `fawkes`                                   |
| `stack`     | Individual stack component           | `uFawkesObs`, `uFawkesPipe`, `uFawkesDevX` |
| `template`  | AI agent starter template            | `uFawkesAI`                                |
| `site`      | Static site / marketing              | `uFawkes.dev`                              |
| `bootstrap` | Minimal bootstrap repo               | `ufawkessec`, `ufawkesdora`                |

## Emergency Bypass

```yaml
emergency:
  label: emergency-bypass # GitHub label that skips merge gates
  allow-override: true # Allow bypass for emergency fixes
```

## YAML Anchors (DRY Config)

Use YAML anchors to avoid repetition:

```yaml
# Define anchors at the top
_defaults: &defaults
  enabled: true
  timeout: 10

# Reference anchors in stages
stages:
  preflight:
    <<: *defaults
  lint:
    <<: *defaults
    languages: [python]
```

## Stages

### Stage 0: Pre-Flight

```yaml
stages:
  preflight:
    enabled: true # Enable/disable this stage
    pr-size-limit: 400 # Max lines changed in PR (0 = no limit)
    commit-format: conventional # Enforce Conventional Commits
```

### Stage 1: Static Analysis

```yaml
stages:
  lint:
    enabled: true
    languages: # List of languages to lint (auto-detect if omitted)
      - python
      - shell
      - yaml
      - markdown
      - json
      - typescript
      - go
      - terraform
    thresholds: # Per-language thresholds
      python:
        min-coverage: 80
      typescript:
        min-coverage: 80
    auto-detect: true # Auto-detect languages from file extensions
```

### Stage 2: Build & Validate

```yaml
stages:
  build:
    enabled: true
    docker: true # Build Docker images if Dockerfiles exist
    registry: ghcr.io/paruff # Container registry
    artifact-retention: 7 # Days to keep build artifacts
```

### Stage 3: Security

```yaml
stages:
  security:
    enabled: true
    sca: true # Software Composition Analysis (Trivy)
    sast: true # Static Application Security Testing (CodeQL)
    container-scan: true # Container image scanning (Trivy)
    policy-enforcement: false # OPA/Rego policy checks
    sbom: true # Generate SBOM (Syft)
```

### Stage 4: Tests

```yaml
stages:
  tests:
    enabled: true
    tiers: # Test tiers to run (in order)
      - unit
      - integration
      - e2e
      - bdd
      - bats
      - terratest
      - acceptance
      - load
    coverage-thresholds:
      unit: 80 # Minimum unit test coverage %
      integration: 70 # Minimum integration test coverage %
    timeout: 30 # Total timeout in minutes
```

### Stage 5: Quality Gates

```yaml
stages:
  quality:
    enabled: true
    lighthouse: true # Lighthouse performance audit
    accessibility: true # axe-core WCAG AA checks
    visual-regression: true # Playwright screenshot comparison
    link-check: true # html-proofer broken link detection
    load-test: true # k6 load testing
    thresholds:
      lighthouse:
        performance: 90 # Minimum Lighthouse performance score
        accessibility: 95 # Minimum Lighthouse accessibility score
      load:
        p95-latency: 500 # Max p95 latency in ms
        error-rate: 1 # Max error rate %
```

### Stage 6: Deploy

```yaml
stages:
  deploy:
    enabled: true
    target: github-pages # Options: github-pages | argocd | helm | static
    environment: production # GitHub environment name
    requires-approval: true # Manual approval required
```

## Full Example

```yaml
version: "1"
repo-type: stack

# YAML anchors for DRY config
_defaults: &defaults
  enabled: true

emergency:
  label: emergency-bypass
  allow-override: true

stages:
  preflight:
    <<: *defaults
    pr-size-limit: 400
    commit-format: conventional

  lint:
    <<: *defaults
    languages: [python, shell, yaml]

  build:
    <<: *defaults
    docker: true
    registry: ghcr.io/paruff

  security:
    <<: *defaults
    sca: true
    sast: true
    container-scan: true

  tests:
    <<: *defaults
    tiers: [unit, integration, e2e]
    coverage-thresholds:
      unit: 80
      integration: 70

  quality:
    <<: *defaults
    lighthouse: true
    accessibility: true
    visual-regression: true
    load-test: true

  deploy:
    <<: *defaults
    target: github-pages
    environment: production
    requires-approval: true
```

## Integration with GitHub Actions

The `.pipeline.yml` is read by reusable workflows via the `pipeline-config` action:

```yaml
# In .github/workflows/ci.yml
- name: Load pipeline config
  uses: ./.github/actions/load-pipeline # Or inline script
  id: pipeline
  with:
    config-path: .pipeline.yml
```

Reusable workflows then use these inputs:

```yaml
- uses: ./.github/workflows/reusable-lint.yml
  with:
    languages: ${{ steps.pipeline.outputs.lint-languages }}
    emergency-bypass: ${{ steps.pipeline.outputs.emergency-bypass }}
```

### Important: Reserved Secret Names

`GITHUB_TOKEN` is a **reserved secret name** in GitHub Actions and cannot be declared in `workflow_call` secrets. It is automatically available in all reusable workflows — do not pass it explicitly:

```yaml
# ✅ Correct — GITHUB_TOKEN is auto-injected
- uses: ./.github/workflows/reusable-lint.yml
  with:
    languages: python

# ❌ Wrong — will fail with "collides with system reserved name"
- uses: ./.github/workflows/reusable-lint.yml
  secrets:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Migration Path

1. Start with `.pipeline.yml` in each repo
2. Update existing workflows to call reusable workflows
3. Gradually replace inline jobs with reusable workflow calls
4. Eventually, all repos use the same reusable workflow library
