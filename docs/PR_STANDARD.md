# PR Standard

## Conventional Commits

Every commit message must follow the Conventional Commits format:

```
type(scope): description
```

### Allowed types

| Type | Usage |
|------|-------|
| `feat` | New feature |
| `fix` | Bug fix |
| docs | Documentation only |
| style | Formatting, no code change |
| refactor | Restructuring without behavior change |
| test | Adding or fixing tests |
| chore | Maintenance, config, tooling |
| ci | CI/CD changes |
| perf | Performance improvement |
| build | Build system or dependency changes |
| revert | Revert a previous commit |

### Scope

Scopes are optional but encouraged. Valid scopes for this repo:

`index` `obs` `pipe` `dora` `sec` `devx` `learn` `css` `nav` `includes` `agents` `skills` `infra` `docs`

### Description

- Use lowercase after `type(scope):`
- Maximum 72 characters
- Use imperative mood ("add feature" not "added feature")
- Do not end with a period

### Examples

```
feat(obs): add DORA metrics dashboard
fix(css): correct hero text wrapping on mobile
chore(deps): bump jekyll to 4.4.1
docs(agents): update agent roster table
ci(guard): add main branch protection checks
```

## Branch naming

Branches must follow the pattern:

```
{type}/{slug}
```

### Examples

```
feat/dora-dashboards
fix/css-hero-alignment
chore/pre-commit-setup
docs/update-readme
ci/add-security-scanning
```

### Rules

- Use lowercase
- Use hyphens as word separators
- Keep slug concise but descriptive
- Never commit directly to `main`

## PR requirements

### Before opening a PR

- Run `make validate` (or equivalent local checks)
- Verify no secrets are committed
- Keep PR size under 400 lines changed (exceptions need `large-pr-approved` label)

### CI checks that must pass

| Check | Required | Description |
|-------|----------|-------------|
| Pre-flight | ✅ | Commit format, PR size, pre-commit hooks, secret detection |
| Lint | ✅ | Language-specific linting + markdown + format |
| Build Site | ✅ | Jekyll build + HTML validation + spell check |
| Security | ✅ | Gitleaks secrets + Trivy vulnerabilities + dependency scan |
| Main CI Guard | ✅ | Branch protection and merge gate checks |

### PR title format

```
type(scope): description
```

Same rules as commit messages. The PR title must match the Conventional Commits format.

### Merge strategy

- Squash merge preferred (produces clean `main` history)
- PR must be approved by at least one reviewer
- All CI checks must pass before merge

### Emergency bypass

In exceptional circumstances, apply the `emergency-bypass` label to skip pre-flight
checks. This is reserved for production incidents only and must be documented in
the PR description.
