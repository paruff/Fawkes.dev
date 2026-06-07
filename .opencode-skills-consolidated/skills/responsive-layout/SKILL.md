---
name: responsive-layout
description: Responsive layout patterns for uFawkes.dev — canonical breakpoints, grid patterns, mobile-first rules, and common layout specs in vanilla CSS/BEM.
license: MIT
compatibility: opencode
---

# Responsive Layout — uFawkes.dev

## Canonical breakpoints (never invent others)

```css
/* Tablet — stacks 2-col grids to 1-col */
@media (max-width: 767px) { }

/* Mobile — reduces padding, font sizes */
@media (max-width: 640px) { }
```

Always mobile-first in logic, even if CSS is written desktop-first. Test at 375px (iPhone SE), 768px (iPad), 1280px (desktop).

## Core layout patterns

### Page wrapper
```css
.page-wrapper {
  max-width: 960px;
  margin: 0 auto;
  padding: 0 24px;
}
@media (max-width: 640px) {
  .page-wrapper { padding: 0 16px; }
}
```

### Hero section
```css
.hero {
  max-width: 720px;
  margin: 0 auto;
  padding: 64px 24px 48px;
  text-align: center;
}
@media (max-width: 640px) {
  .hero { padding: 40px 16px 32px; }
}
```

### 2-column grid (stack family)
```css
.grid--2col {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}
@media (max-width: 767px) {
  .grid--2col { grid-template-columns: 1fr; }
}
```

### 2-column with sidebar
```css
.grid--sidebar {
  display: grid;
  grid-template-columns: 240px 1fr;
  gap: 32px;
}
@media (max-width: 767px) {
  .grid--sidebar { grid-template-columns: 1fr; }
}
```

## Typography responsive rules

| Element | Desktop | Mobile (≤640px) |
|---------|---------|-----------------|
| H1 | 36px | 28px |
| H2 | 24px | 20px |
| H3 | 18px | 16px |
| Body | 16px | 15px |
| Code | 14px | 13px |

## Touch targets

All interactive elements: minimum 44×44px touch target.
For links that appear smaller visually, use padding to extend the tap area:
```css
.nav__link {
  padding: 12px 16px; /* ensures 44px height */
}
```

## Nav responsive behavior

At ≤767px:
- Hamburger menu or collapsed nav
- Dropdown becomes full-width
- Logo remains visible

Current `assets/js/nav.js` handles dropdown. Check before adding new nav JS.
