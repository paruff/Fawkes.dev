# uFawkes CI Pipeline — Phase 1 Proof of Concept

## Summary

Phase 1 of the Canonical CI Pipeline has been implemented for **uFawkesAI** as a proof of concept. This demonstrates the reusable workflow pattern that will be rolled out to all uFawkes repositories.

## Files Created/Updated

### New Files

| File                                       | Purpose                                  |
| ------------------------------------------ | ---------------------------------------- |
| `.pipeline.yml`                            | Pipeline configuration for uFawkesAI     |
| `.github/workflows/reusable-preflight.yml` | Stage 0: Pre-flight checks (reusable)    |
| `.github/workflows/reusable-lint.yml`      | Stage 1: Static analysis (reusable)      |
| `docs/pipeline-schema.md`                  | Schema documentation for `.pipeline.yml` |

### Updated Files

| File                               | Changes                                            |
| ---------------------------------- | -------------------------------------------------- |
| `.github/workflows/ci.yml`         | Refactored to use reusable workflows               |
| `.github/workflows/ci-quality.yml` | Updated to use reusable workflows + existing gates |

## What's Implemented

### Stage 0: Pre-flight Checks

- ✅ Pre-commit hook validation
- ✅ PR size gate (≤400 lines, with override labels)
- ✅ Commit message format enforcement (Conventional Commits)
- ✅ Secret detection (Gitleaks + .env.example validation)
- ✅ Emergency bypass support (`emergency-bypass` label)
- ✅ DORA timestamp logging

### Stage 1: Static Analysis

- ✅ Language auto-detection from file changes
- ✅ Shell linting (ShellCheck)
- ✅ YAML linting (yamllint)
- ✅ JSON validation
- ✅ Markdown linting (markdownlint)
- ✅ Format checking (Prettier)
- ✅ Parallel execution of independent linters
- ✅ Emergency bypass support

### Configuration

- ✅ `.pipeline.yml` schema with YAML anchors for DRY config
- ✅ Repo-type profiles (template, core, stack, site, bootstrap)
- ✅ Per-stage enable/disable
- ✅ Language selection per repo

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    CI Pipeline Architecture                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  .pipeline.yml (config)                                         │
│       │                                                          │
│       ▼                                                          │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  ci.yml (orchestrator)                                  │    │
│  │    ├── reusable-preflight.yml (Stage 0)                 │    │
│  │    ├── reusable-lint.yml (Stage 1)                      │    │
│  │    ├── reusable-build.yml (Stage 2)    [Phase 2]        │    │
│  │    ├── reusable-security.yml (Stage 3) [Phase 2]        │    │
│  │    ├── reusable-tests.yml (Stage 4)    [Phase 3]        │    │
│  │    ├── reusable-quality.yml (Stage 5)  [Phase 4]        │    │
│  │    └── reusable-deploy.yml (Stage 6)   [Phase 4]        │    │
│  └─────────────────────────────────────────────────────────┘    │
│                                                                  │
│  Emergency Bypass: `emergency-bypass` label                     │
│  PR Size Override: `large-pr-approved` label                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Testing

### Local Testing

```bash
cd uFawkesAI

# Run preflight checks
bash scripts/preflight.sh

# Validate YAML syntax
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/ci.yml'))"
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/ci-quality.yml'))"
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/reusable-preflight.yml'))"
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/reusable-lint.yml'))"
```

### CI Testing

Push changes to a PR branch and verify:

1. `preflight` job runs and passes
2. `lint` job runs language-specific linters
3. `pipeline-summary` reports overall status

## Next Steps

### Phase 2: Build & Security (Week 2)

- Create `reusable-build.yml`
- Create `reusable-security-scanning.yml`
- Test with `uFawkesObs`

### Phase 3: Test Integration (Week 3)

- Create `reusable-tests.yml`
- Create `reusable-load-test.yml`
- Test with `fawkes`

### Phase 4: Quality & Deploy (Week 4)

- Create `reusable-quality.yml`
- Create `reusable-deploy.yml`
- Test with `uFawkes.dev`

### Phase 5: Rollout (Week 5)

- Roll out to all repos
- Documentation and training

## Key Design Decisions

1. **Reusable Workflows**: Each stage is a separate reusable workflow that can be called from any repo
2. **YAML Anchors**: `.pipeline.yml` uses YAML anchors for DRY configuration
3. **Emergency Bypass**: `emergency-bypass` label allows overriding merge gates
4. **DORA Timestamps**: Every job logs start/finish timestamps for DORA metrics
5. **Language Auto-detection**: Lint jobs only run for languages present in the PR
6. **Fail-fast**: Preflight runs first and aborts pipeline on failure

## Rollout Plan

| Repo        | Phase   | Stages     | Target Date |
| ----------- | ------- | ---------- | ----------- |
| uFawkesAI   | Phase 1 | 0, 1       | Current     |
| uFawkesObs  | Phase 2 | 0, 1, 2, 3 | Week 2      |
| fawkes      | Phase 3 | 0-5        | Week 3      |
| uFawkes.dev | Phase 4 | 0-6        | Week 4      |
| uFawkesPipe | Phase 5 | 0-3        | Week 5      |
| uFawkesDevX | Phase 5 | 0-3        | Week 5      |
| ufawkessec  | Phase 5 | 0, 1       | Week 5      |
| ufawkesdora | Phase 5 | 0, 1       | Week 5      |
