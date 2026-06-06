# Skill: Token System

## Purpose
Enable the Design System Agent to define and maintain **semantic design tokens** for uFawkes.dev.  
Tokens form the foundation of the Fawkes Design System (FDS).

## Used By
- Design System Agent
- UI Agent
- Build Agent
- Review Agent

## Capabilities
- Define semantic tokens for:
  - Color (fg, bg, border, accent)
  - Typography (font sizes, weights, line heights)
  - Spacing (4/8px scale)
  - Radii
  - Shadows
  - Motion
- Map tokens to Tailwind configuration.
- Ensure accessibility (contrast ratios).
- Propose token naming conventions.

## Outputs
- Token tables
- Tailwind theme mapping instructions
- Accessibility notes
- Token usage guidelines

## Constraints
- Tokens must be semantic, not aesthetic.
- Must support light/dark modes.
- Must be stable and versioned.
