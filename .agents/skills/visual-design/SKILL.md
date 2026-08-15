---
name: visual-design
description: Visual design rules for uFawkes.dev — hierarchy, spacing rhythm, typography scale, color usage, and interaction patterns. All expressed in vanilla CSS/BEM constraints.
license: MIT
compatibility: opencode
---

# Visual Design — uFawkes.dev

## Design philosophy

uFawkes.dev is a **developer-facing platform site**. Visual decisions must serve comprehension and trust, not decoration. Every visual choice should answer: does this help a builder evaluate the stack faster?

Principles:

1. **Signal over noise** — remove everything that doesn't help the visitor decide
2. **Generous whitespace** — breathing room signals confidence
3. **Contrast hierarchy** — the most important thing on each page must be obviously most important
4. **Honest aesthetics** — no marketing gloss; clinical precision builds developer trust

## Typography scale

Use px values directly (no rem, no CSS variables yet):

| Level       | Size | Weight | Color     | Usage                          |
| ----------- | ---- | ------ | --------- | ------------------------------ |
| H1          | 36px | 700    | `#111827` | Page title — one per page      |
| H2          | 24px | 600    | `#111827` | Section headings               |
| H3          | 18px | 600    | `#111827` | Card headers, subsections      |
| Body        | 16px | 400    | `#374151` | Paragraph text                 |
| Small       | 14px | 400    | `#6b7280` | Metadata, captions, badges     |
| Code        | 14px | 400    | `#111827` | Monospace — system-ui fallback |
| Line height | —    | —      | 1.6       | All body text                  |

Mobile (≤640px): reduce H1 to 28px, H2 to 20px.

## Spacing rhythm

All spacing in multiples of 8px:

| Token   | Value | Usage                                            |
| ------- | ----- | ------------------------------------------------ |
| space-1 | 8px   | Tight — between related elements                 |
| space-2 | 16px  | Standard — card padding (mobile), between items  |
| space-3 | 24px  | Card padding (desktop), section internal spacing |
| space-4 | 32px  | Between major sections                           |
| space-6 | 48px  | Hero padding, major section breaks               |
| space-8 | 64px  | Page-level vertical rhythm                       |

## Color usage rules

```
#16a34a  — brand green
  Use: CTAs, live badges, Dojo accent border, hover borders on cards
  Never use as background for large text areas
  Contrast on white: 4.7:1 (AA pass)

#111827  — text primary
  Use: H1, H2, H3, strong emphasis

#374151  — text secondary
  Use: body paragraphs, card descriptions

#6b7280  — text muted
  Use: metadata, dates, read time, repo name labels

#e5e7eb  — border default
  Use: card borders, dividers, horizontal rules

#f9fafb  — bg subtle
  Use: section backgrounds (alternating), code block backgrounds

#ffffff  — bg default
  Use: page background, card backgrounds
```

**Never**: use color as the only differentiator. Always pair color with shape, text, or icon.

## Component visual rules

### Cards (stack cards, learn cards)

```
background:    #ffffff
border:        1px solid #e5e7eb
border-radius: 8px
padding:       24px (desktop), 16px (mobile)
hover:         border-color #16a34a, box-shadow 0 2px 8px rgba(22,163,74,0.12)
transition:    border-color 150ms ease, box-shadow 150ms ease
```

### Primary CTA buttons

```
background:    #16a34a
color:         #ffffff
padding:       12px 24px
border-radius: 6px
font-size:     16px
font-weight:   600
border:        none
hover:         background #15803d (10% darker)
focus:         outline 2px solid #16a34a, outline-offset 2px
```

### Code blocks / quick start commands

```
background:    #f9fafb
border:        1px solid #e5e7eb
border-left:   3px solid #16a34a
border-radius: 4px
padding:       16px
font-family:   ui-monospace, 'Cascadia Code', monospace
font-size:     14px
color:         #111827
overflow-x:    auto
```

### Live / status badges

```
background:    #dcfce7
color:         #16a34a
border-radius: 12px
padding:       2px 10px
font-size:     12px
font-weight:   600
```

## Layout grid

### Homepage stack family

```css
.stack-family__grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}
@media (max-width: 767px) {
  .stack-family__grid {
    grid-template-columns: 1fr;
  }
}
```

### Hero section

```
max-width:  720px
margin:     0 auto
text-align: center
padding:    64px 24px 48px
```

### Content sections

```
max-width:  960px
margin:     0 auto
padding:    48px 24px
```

## Interaction patterns

### Hover states

- Duration: 150ms ease (not faster — feels jittery; not slower — feels sluggish)
- Only border-color, box-shadow, background-color — never layout properties
- Always pair with `prefers-reduced-motion` override (see accessibility-workflow skill)

### Focus rings

- 2px solid `#16a34a`, outline-offset 2px
- Never remove focus rings — only style them

### Transitions to avoid

- Transform on cards (causes layout thrash on low-end hardware)
- Opacity transitions on large blocks
- Color transitions on text (readability flash)
