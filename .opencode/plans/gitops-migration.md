# GitOps Migration Plan — uFawkes Product Suite

> Source of truth for GitOps migration across all 8 repos.
> Execute phases in order. Each phase produces a testable, committable result.

---

## Current State Audit

### fawkes (reference model) — ✅ COMPLETE
| Component | Status |
|-----------|--------|
| Pre-commit | ✅ 40+ hooks (gitleaks, yamllint, shellcheck, shfmt, hadolint, trivy, tflint, tfsec, kubeconform, markdownlint, prettier, black, ruff, flake8, golangci-lint) |
| CI workflows | ✅ 14 workflows (pre-commit 4-layer, code-quality, security-scanning, supply-chain, policy-enforcement, sbom-generation, image-signing, tracer-bullet, accessibility-testing, terraform-tests, ci-pr-size, deploy, build-mcp-k8s-server, idp-e2e-tests) |
| Dependabot | ✅ Docker + GitHub Actions weekly |
| Branch protection | ❌ None (needs Rulesets API) |
| CODEOWNERS | ❌ Missing |
| Setup script | ✅ `make pre-commit-setup` |

### uFawkesObs — ⚠️ NEEDS MIGRATION
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ⚠️ 10 workflows (apps-test, ci-pr-size, compose-smoke, deploy, integration-tests, lint, security, supply-chain, unit-tests, validate-config) — many overlapping/duplicated |
| Dependabot | ❌ Missing |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

### uFawkesPipe — ⚠️ NEEDS MIGRATION
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ⚠️ 1 workflow (ci.yml) — minimal |
| Dependabot | ❌ Missing |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

### uFawkesAI — ⚠️ NEEDS MIGRATION
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ⚠️ 5 workflows (ci-quality, ci, dependency-review, doc-freshness, secret-scan) |
| Dependabot | ✅ Has dependabot.yml |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

### uFawkesDORA — 🆕 FRESH (GitOps from day 1)
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ❌ None |
| Dependabot | ❌ Missing |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

### uFawkesSec — 🆕 FRESH (GitOps from day 1)
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ❌ None |
| Dependabot | ❌ Missing |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

### uFawkesDevX — 🆕 FRESH (GitOps from day 1)
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ❌ None |
| Dependabot | ❌ Missing |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

### uFawkes.dev — ⚠️ NEEDS MIGRATION
| Component | Status |
|-----------|--------|
| Pre-commit | ❌ Missing |
| CI workflows | ⚠️ 3 workflows (ci.yml, deploy.yml, opencode.yml) |
| Dependabot | ❌ Missing |
| Branch protection | ❌ None |
| CODEOWNERS | ❌ Missing |

---

## Phase 0: Create Reusable Templates (in fawkes)

**Goal:** Standardize GitOps components as copyable templates in fawkes repo.

### 0.1 Pre-commit Config (subset for uFawkes repos)

Create `fawkes/.gitops-templates/pre-commit-config.yaml` — a stripped-down version of fawkes' full config, appropriate for Jekyll/Markdown repos:

```yaml
# Pre-commit hooks for uFawkes product suite repos
# Install: make pre-commit-setup
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.5.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-json
      - id: check-added-large-files
        args: ["--maxkb=1024"]
      - id: check-merge-conflict
      - id: mixed-line-ending
        args: ["--fix=lf"]
      - id: detect-private-key

  - repo: https://github.com/adrienverge/yamllint
    rev: v1.33.0
    hooks:
      - id: yamllint
        args: ["-c", ".yamllint"]

  - repo: https://github.com/igorshubovych/markdownlint-cli
    rev: v0.38.0
    hooks:
      - id: markdownlint
        args: ["--config", ".markdownlint.json", "--fix"]

  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v3.1.0
    hooks:
      - id: prettier
        types_or: [json, yaml, markdown]
        args: ["--write", "--ignore-unknown"]

  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.1
    hooks:
      - id: gitleaks

  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.4.0
    hooks:
      - id: detect-secrets
        args: ["--baseline", ".secrets.baseline"]
```

### 0.2 CI Workflow (single validation workflow)

Create `fawkes/.gitops-templates/ci-validate.yml` — single workflow that runs all pre-commit hooks in parallel layers:

```yaml
name: CI

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]
  workflow_dispatch:

permissions:
  contents: read
  pull-requests: write

jobs:
  validate:
    name: Validate
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@v6
        with:
          fetch-depth: 0
      - uses: actions/setup-python@v6
        with:
          python-version: "3.11"
      - run: pip install pre-commit
      - uses: actions/cache@v5
        with:
          path: ~/.cache/pre-commit
          key: pre-commit-${{ runner.os }}-${{ hashFiles('.pre-commit-config.yaml') }}
      - run: pre-commit run --all-files
```

### 0.3 Dependabot Config

Create `fawkes/.gitops-templates/dependabot.yml`:

```yaml
version: 2
updates:
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

### 0.4 CODEOWNERS

Create `fawkes/.gitops-templates/CODEOWNERS`:

```
* @paruff
```

### 0.5 Makefile targets

Create `fawkes/.gitops-templates/Makefile-fragment`:

```makefile
pre-commit-setup: ## Install pre-commit hooks
	@pip install pre-commit
	@pre-commit install
	@echo "✅ Pre-commit hooks installed"

pre-commit-run: ## Run all pre-commit hooks
	@pre-commit run --all-files

validate: pre-commit-run ## Validate all files
```

### 0.6 Supporting configs

Create `fawkes/.gitops-templates/.yamllint`, `.markdownlint.json`, `.gitleaks.toml`, `.secrets.baseline` — copy from fawkes root.

### 0.7 Deliverable

| File | Location |
|------|----------|
| `.gitops-templates/pre-commit-config.yaml` | fawkes repo |
| `.gitops-templates/ci-validate.yml` | fawkes repo |
| `.gitops-templates/dependabot.yml` | fawkes repo |
| `.gitops-templates/CODEOWNERS` | fawkes repo |
| `.gitops-templates/Makefile-fragment` | fawkes repo |
| `.gitops-templates/.yamllint` | fawkes repo |
| `.gitops-templates/.markdownlint.json` | fawkes repo |
| `.gitops-templates/.gitleaks.toml` | fawkes repo |
| `.gitops-templates/.secrets.baseline` | fawkes repo (generated) |

---

## Phase 1: Fresh Repos (DORA, Sec, DevX)

**Goal:** Initialize GitOps from day 1 — no migration, clean start.

**Repos:** ufawkesdora, ufawkessec, uFawkesDevX

### For each repo:

1. Clone repo locally
2. Copy template files from `.gitops-templates/` in fawkes:
   - `pre-commit-config.yaml` → `.pre-commit-config.yaml`
   - `ci-validate.yml` → `.github/workflows/ci.yml`
   - `dependabot.yml` → `.github/dependabot.yml`
   - `CODEOWNERS` → `.github/CODEOWNERS`
   - `.yamllint` → `.yamllint`
   - `.markdownlint.json` → `.markdownlint.json`
   - `.gitleaks.toml` → `.gitleaks.toml`
   - `.secrets.baseline` → `.secrets.baseline` (generate with `gitleaks detect`)
3. Add `Makefile` with `pre-commit-setup` and `validate` targets
4. Add `.gitignore` (standard for repo type)
5. Run `pre-commit run --all-files` — fix any failures
6. Commit: `chore(gitops): initialize GitOps standards`
7. Push to main — CI workflow runs and passes

### Deliverables per repo:
- `.pre-commit-config.yaml`
- `.github/workflows/ci.yml`
- `.github/dependabot.yml`
- `.github/CODEOWNERS`
- `.yamllint`
- `.markdownlint.json`
- `.gitleaks.toml`
- `.secrets.baseline`
- `Makefile`
- `.gitignore`

---

## Phase 2: Existing Repos (Obs, Pipe, AI, .dev)

**Goal:** Migrate to standardized GitOps while preserving existing CI.

### 2.1 uFawkesObs (10 workflows → consolidate)

**Current:** 10 workflows (apps-test, ci-pr-size, compose-smoke, deploy, integration-tests, lint, security, supply-chain, unit-tests, validate-config)

**Action:**
1. Add pre-commit config + supporting files (from templates)
2. Add CODEOWNERS
3. Add Makefile targets
4. **Do NOT delete existing workflows yet** — add pre-commit as parallel layer
5. Create branch `chore/gitops-migration`
6. Add all GitOps files
7. Run `pre-commit run --all-files` — fix failures
8. Commit: `chore(gitops): add pre-commit, CODEOWNERS, dependabot`
9. Push, verify CI passes
10. **Future PR:** Consolidate 10 workflows → streamlined set (separate task)

### 2.2 uFawkesPipe (1 workflow)

**Current:** 1 workflow (ci.yml)

**Action:**
1. Add pre-commit config + supporting files
2. Add CODEOWNERS
3. Add Makefile targets
4. Rename existing `ci.yml` → keep as-is (it's minimal)
5. Add new `ci.yml` as the pre-commit validation (rename existing to `ci-legacy.yml` or merge)
6. Commit: `chore(gitops): add pre-commit, CODEOWNERS, dependabot`
7. Push, verify CI passes

### 2.3 uFawkesAI (5 workflows)

**Current:** 5 workflows (ci-quality, ci, dependency-review, doc-freshness, secret-scan)

**Action:**
1. Add pre-commit config + supporting files
2. Add CODEOWNERS
3. Add Makefile targets
4. Keep existing 5 workflows (they're well-structured)
5. Add pre-commit as additional validation layer
6. Commit: `chore(gitops): add pre-commit, CODEOWNERS`
7. Push, verify CI passes

### 2.4 uFawkes.dev (3 workflows)

**Current:** 3 workflows (ci.yml, deploy.yml, opencode.yml)

**Action:**
1. Add pre-commit config + supporting files
2. Add CODEOWNERS
3. Add Makefile targets
4. Keep existing workflows (Jekyll-specific)
5. Add pre-commit as additional validation layer
6. Commit: `chore(gitops): add pre-commit, CODEOWNERS, dependabot`
7. Push, verify CI passes

---

## Phase 3: Branch Protection (All 8 Repos)

**Goal:** Protect `main` branch via GitHub Rulesets API.

### 3.1 Ruleset Configuration

For each repo, create a ruleset via `gh api`:

```bash
gh api repos/paruff/{repo}/rulesets \
  --method POST \
  --input - << 'EOF'
{
  "name": "main-protection",
  "target": "branch",
  "enforcement": "active",
  "conditions": {
    "ref_name": {
      "include": ["refs/heads/main"],
      "exclude": []
    }
  },
  "rules": [
    { "type": "pull_request",
      "parameters": {
        "required_approving_review_count": 0,
        "dismiss_stale_reviews_on_push": true,
        "require_code_owner_review": false,
        "require_last_push_approval": false
      }
    },
    { "type": "required_status_checks",
      "parameters": {
        "required_status_checks": [
          { "context": "Validate" }
        ],
        "strict_required_status_checks_policy": false
      }
    },
    { "type": "required_linear_history" },
    { "type": "non_fast_forward" }
  ]
}
EOF
```

### 3.2 Notes
- `required_approving_review_count: 0` — PR required but no reviewers needed (solo maintainer)
- Status check name must match the job name in CI workflow (`Validate`)
- `required_linear_history` ensures merge commits (no force pushes)
- `non_fast_forward` prevents force pushes to main

### 3.3 Apply to all repos:

```bash
for repo in fawkes uFawkesObs uFawkesPipe uFawkesAI ufawkesdora ufawkessec uFawkesDevX uFawkes.dev; do
  # Apply ruleset (save JSON to file first, then POST)
  gh api repos/paruff/$repo/rulesets --method POST --input ruleset.json
done
```

---

## Phase 4: Opencode GitOps Guidance

**Goal:** Make opencode agents follow GitOps methodology automatically.

### 4.1 Create `.opencode/agents/gitops.md`

New agent definition that enforces GitOps workflow:

```markdown
---
description: GitOps-enforced build agent — creates branches, runs pre-commit, opens PRs
mode: subagent
permission:
  read: allow
  edit: allow
  bash:
    "git *": allow
    "pre-commit *": allow
    "make *": allow
    "gh *": allow
---

# Agent: GitOps Build

## Role
You are the GitOps-enforced build agent. ALL changes follow this workflow:

### 1. Branch
```bash
git checkout -b {type}/{scope}-{short-description}
```
Branch naming: `fix/css-hero-alignment`, `feat/dora-dashboards`, `chore/pre-commit-setup`

### 2. Implement
- One file per commit
- Run `make validate` (or `pre-commit run --all-files`) before committing
- If pre-commit fails, fix ALL failures before committing

### 3. Commit
```bash
git add {file}
git commit -m "{type}({scope}): {description}"
```
Conventional commits: `fix`, `feat`, `chore`, `docs`, `style`, `refactor`, `test`, `ci`

### 4. Push & PR
```bash
git push -u origin {branch}
gh pr create --title "{type}({scope}): {description}" --body "..."
```

### 5. Verify
- CI must pass (pre-commit validation)
- If CI fails, fix on same branch (don't merge broken code)

## Constraints
- NEVER commit directly to main
- NEVER skip pre-commit hooks
- NEVER force push to main
- ALWAYS create a PR for review
- ONE file per commit (except bulk config additions)
```

### 4.2 Update `AGENTS.md`

Add GitOps section to the main AGENTS.md:

```markdown
## GitOps Working Rules

All code changes MUST follow GitOps methodology:

1. **Branch first** — never commit directly to main
2. **Pre-commit always** — `make validate` before every commit
3. **PR for review** — even solo, create PRs for audit trail
4. **CI must pass** — never merge broken code
5. **Conventional commits** — `fix(scope): description`

### Quick commands
```bash
make pre-commit-setup   # one-time setup
git checkout -b fix/something  # create branch
make validate           # run all checks
git commit -m "fix(scope): description"
git push -u origin fix/something
gh pr create
```
```

### 4.3 Update planning agent

Modify `~/.config/opencode/agents/planning.md` to include GitOps enforcement in task assignments:

Add to the "Sequence next tasks" section:
```
Next: @build → implement issue #N on branch {type}/{scope}-{desc}
Then: @review → validate #N
Then: @build → commit fix(scope): description (#N) and open PR
```

---

## Execution Order

| Step | Phase | Action | Repos |
|------|-------|--------|-------|
| 1 | 0.1 | Create `.gitops-templates/` in fawkes | fawkes |
| 2 | 0.2 | Create CI workflow template | fawkes |
| 3 | 0.3 | Create dependabot template | fawkes |
| 4 | 0.4 | Create CODEOWNERS template | fawkes |
| 5 | 0.5 | Create Makefile fragment | fawkes |
| 6 | 0.6 | Create supporting configs | fawkes |
| 7 | 1 | Initialize DORA, Sec, DevX with templates | ufawkesdora, ufawkessec, uFawkesDevX |
| 8 | 2.1 | Migrate uFawkesObs | uFawkesObs |
| 9 | 2.2 | Migrate uFawkesPipe | uFawkesPipe |
| 10 | 2.3 | Migrate uFawkesAI | uFawkesAI |
| 11 | 2.4 | Migrate uFawkes.dev | uFawkes.dev |
| 12 | 3 | Apply branch protection Rulesets | all 8 repos |
| 13 | 4.1 | Create gitops.md agent | opencode config |
| 14 | 4.2 | Update AGENTS.md | uFawkes.dev |
| 15 | 4.3 | Update planning agent | opencode config |

---

## Success Criteria

- [ ] All 8 repos have `.pre-commit-config.yaml`
- [ ] All 8 repos have `ci.yml` workflow that passes
- [ ] All 8 repos have `dependabot.yml`
- [ ] All 8 repos have `.github/CODEOWNERS`
- [ ] All 8 repos have branch protection via Rulesets (PR required, status check required)
- [ ] `make validate` works in every repo
- [ ] Opencode agents create branches and PRs by default
- [ ] No direct commits to main (enforced by Rulesets)

---

## Open Questions

1. **Should we consolidate uFawkesObs workflows now or later?** Current: 10 workflows. Recommendation: defer consolidation to a separate PR after GitOps is in place.

2. **Status check name:** The CI workflow job is named `Validate` — this must match the Ruleset's `required_status_checks.context`. Confirm this is correct.

3. **uFawkesPipe rename:** The existing `ci.yml` in uFawkesPipe needs to be either renamed or merged with the new pre-commit CI. Recommendation: rename existing → `ci-legacy.yml`, add new `ci.yml` as the standard.

4. **CODEOWNERS scope:** `* @paruff` means you're requested for review on every PR. For solo work this is fine, but if you add contributors later, update CODEOWNERS per-repo.

---

*Created: 2026-06-11*
*Status: Ready for execution*
