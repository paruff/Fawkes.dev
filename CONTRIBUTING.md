# Contributing to uFawkes.dev

Thanks for your interest in contributing! This guide covers the process for contributing to the uFawkes.dev marketing site.

## Getting started

1. Fork and clone the repo
2. Install dependencies: `bundle install`
3. Start the dev server: `make serve`
4. Open http://localhost:4000

## Making changes

### One file per commit

Each commit should be a single logical change. Don't bundle unrelated edits.

### CSS conventions

- **Single file:** `assets/css/main.css` — append only, never reorder
- **Naming:** BEM strictly (`.block`, `.block__element`, `.block--modifier`)
- **Breakpoints:** 767px (tablet), 640px (mobile) — never invent others
- **Colors:** Use hex directly (#16a34a, #111827, etc.) — no CSS variables yet
- **Spacing:** Multiples of 8px

### Liquid rules

- Allowed filters: `relative_url`, `absolute_url`, `url_encode`, `date`, `markdownify`, `strip_html`, `truncate`, `slugify`
- Never use: `{% unless %}`, `{% case %}`, multi-variable assign chains
- Always verify included files exist before referencing

### Front matter

- Preserve all existing keys when editing a page
- Only add new keys — never remove unless explicitly instructed
- `description` must be page-specific, not the global tagline

## PR process

1. Create a feature branch from `main`
2. Make your changes (one file per commit preferred)
3. Run `make build` — it must pass
4. Open a PR with a clear title and description
5. Wait for CI to pass and for review

### Commit format

```
fix(scope): description (#issue-number)
```

Valid scopes: `index` `obs` `pipe` `dora` `sec` `devx` `learn` `css` `nav` `includes` `infra` `docs`

## Tech stack

- Jekyll 4.4.1 (GitHub Pages)
- minima theme (overridden via `_layouts/`, `_includes/`)
- Vanilla CSS (no Tailwind, no SCSS build)
- Vanilla JS (no npm, no bundler)
- Liquid templating (whitelisted filters only)

## Reporting issues

Use the [bug report template](https://github.com/paruff/uFawkes.dev/issues/new?template=bug_report.md) for bugs, or the [feature request template](https://github.com/paruff/uFawkes.dev/issues/new?template=feature_request.md) for suggestions.

## Code of conduct

Be kind, be respectful, be constructive. We're all here to build something useful.
