---
name: component-workflow
description: Full lifecycle for uFawkes components — anatomy definition, implementation spec, styling rules, and Jekyll/Liquid integration patterns. For UI and Build agents.
license: MIT
compatibility: opencode
---

# Component Workflow

## Lifecycle

```
UX defines need → UI specifies anatomy + styling → Build implements → Review validates
```

## Anatomy template

Every component specification must include:

```
Component: .component-name
─────────────────────────────
Purpose: one sentence

HTML structure:
  .component-name              root element
  .component-name__part-a      description
  .component-name__part-b      description
  .component-name--modifier    variant description

Liquid template pattern:
  (show how it would be used in Jekyll — no production code, just structure)

Visual rules: (see visual-design skill for tokens)
  background, border, padding, typography, states

Responsive:
  ≤767px: changes
  ≤640px: changes

Accessibility:
  ARIA roles, alt text rules, focus behavior

Dependencies:
  CSS appended after line N of main.css
  Includes required: filename.html
```

## Jekyll-specific integration patterns

### Include-based components
For reusable components, Build agent creates `_includes/component-name.html`.
Reference: `{% include component-name.html param="value" %}`
Always verify the include file exists before referencing.

### Front-matter-driven components
Stack pages use front matter arrays rendered by `_layouts/stack.html`:
```liquid
{% for feature in page.features %}
  <li>{{ feature }}</li>
{% endfor %}
```

### Liquid template rules for components
- Use `{% if page.key %}...{% endif %}` for optional sections
- Never use `{% unless %}` — use `{% if page.key == false %}`
- Conditional classes: `class="component{% if page.coming_soon %} component--soon{% endif %}"`

## Current component inventory

| Component | Status | BEM class | Location |
|-----------|--------|-----------|----------|
| Stack card | Exists | .stack-card (TBD) | index.md inline |
| Nav dropdown | Exists | (minima override) | _includes/header.html |
| Quick start block | Exists | (unstyled) | _layouts/stack.html |
| Dojo callout | Planned | .dojo-callout | index.md + main.css |
| Guide meta | Planned | .guide-meta | _includes/guide-meta.html |
| Live badge | Exists | .badge--live (TBD) | inline |
