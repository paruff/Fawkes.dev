#!/usr/bin/env bash
# =============================================================================
# uFawkes Agent & Skill Consolidation Script
# =============================================================================
# Purpose: Migrate agents and skills from .opencode/ (project-local) to
#          ~/.config/opencode/ (global), consolidate 29 skills → 12,
#          and write the corrected .opencode/opencode.json.
#
# Usage:
#   chmod +x consolidate-agents.sh
#   ./consolidate-agents.sh [--dry-run] [--skip-backup]
#
# Flags:
#   --dry-run      Print actions without executing them
#   --skip-backup  Skip the backup step (not recommended)
#
# What it does:
#   1. Backs up existing .opencode/ dir
#   2. Creates ~/.config/opencode/{agents,skills}/ directories
#   3. Moves agent .md files to global location
#   4. Installs the 12 consolidated skills to global location
#   5. Maps old skill names → new consolidated names (with audit log)
#   6. Writes .opencode/opencode.json with correct permission gates + MCP config
#   7. Prints a verification report
#
# =============================================================================

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_AGENTS_DIR="$REPO_DIR/.opencode/agents"
LOCAL_SKILLS_DIR="$REPO_DIR/.opencode/skills"
GLOBAL_AGENTS_DIR="$HOME/.config/opencode/agents"
GLOBAL_SKILLS_DIR="$HOME/.config/opencode/skills"
BACKUP_DIR="$REPO_DIR/.opencode-backup-$(date +%Y%m%d-%H%M%S)"
OPENCODE_JSON="$REPO_DIR/.opencode/opencode.json"

DRY_RUN=false
SKIP_BACKUP=false

# New consolidated skill names (12 total)
NEW_SKILLS=(
  jekyll-site-conventions
  ux-audit
  accessibility-workflow
  visual-design
  component-workflow
  responsive-layout
  design-system-workflow
  content-strategy
  cross-agent-coordination
  planning-workflow
  code-quality
  issue-format
)

# Old skill → new skill mapping (29 → 12)
# Format: "old-skill-name:new-skill-name"
SKILL_MAP=(
  "accessibility:accessibility-workflow"
  "accessibility-review:accessibility-workflow"
  "accessibility-implementation:accessibility-workflow"
  "astro-components:DELETE"
  "code-quality:code-quality"
  "component-anatomy:component-workflow"
  "component-implementation:component-workflow"
  "component-styling:component-workflow"
  "content-strategy:content-strategy"
  "cross-agent-coordination:cross-agent-coordination"
  "dependency-mapping:cross-agent-coordination"
  "design-system-compliance:design-system-workflow"
  "design-system-documentation:design-system-workflow"
  "experience-principles:ux-audit"
  "information-architecture:ux-audit"
  "interaction-motion:visual-design"
  "layout-composition:visual-design"
  "layout-implementation:responsive-layout"
  "pattern-library:design-system-workflow"
  "prioritization:planning-workflow"
  "responsive-design:responsive-layout"
  "roadmapping:planning-workflow"
  "success-criteria:planning-workflow"
  "tailwind-tokens:DELETE"
  "token-system:design-system-workflow"
  "ui-consistency:visual-design"
  "user-journeys:ux-audit"
  "ux-alignment:ux-audit"
  "visual-hierarchy:visual-design"
  "wireframing:ux-audit"
)

# Agent files to migrate
AGENT_FILES=(
  build.md
  design-system.md
  infra.md
  planning.md
  review.md
  ui.md
  ux.md
)

# ── Helpers ───────────────────────────────────────────────────────────────────

log()     { echo "  $*"; }
info()    { echo ""; echo "▶ $*"; }
success() { echo "  ✅ $*"; }
warn()    { echo "  ⚠️  $*"; }
error()   { echo "  ❌ $*" >&2; }

run() {
  if $DRY_RUN; then
    echo "  [DRY RUN] $*"
  else
    eval "$@"
  fi
}

# ── Parse flags ───────────────────────────────────────────────────────────────

for arg in "$@"; do
  case $arg in
    --dry-run)     DRY_RUN=true ;;
    --skip-backup) SKIP_BACKUP=true ;;
    *) error "Unknown flag: $arg"; exit 1 ;;
  esac
done

$DRY_RUN && echo ""
$DRY_RUN && echo "════════════════════════════════════════"
$DRY_RUN && echo "  DRY RUN MODE — no changes will be made"
$DRY_RUN && echo "════════════════════════════════════════"

# ── Step 1: Backup ────────────────────────────────────────────────────────────

info "Step 1: Backup"

if $SKIP_BACKUP; then
  warn "Skipping backup (--skip-backup flag set)"
else
  if [ -d "$REPO_DIR/.opencode" ]; then
    run "cp -r '$REPO_DIR/.opencode' '$BACKUP_DIR'"
    success "Backed up .opencode/ → $BACKUP_DIR"
  else
    warn ".opencode/ directory not found — nothing to back up"
  fi
fi

# ── Step 2: Create global directories ─────────────────────────────────────────

info "Step 2: Create global agent/skill directories"

run "mkdir -p '$GLOBAL_AGENTS_DIR'"
success "Created $GLOBAL_AGENTS_DIR"

run "mkdir -p '$GLOBAL_SKILLS_DIR'"
success "Created $GLOBAL_SKILLS_DIR"

# ── Step 3: Migrate agent files ───────────────────────────────────────────────

info "Step 3: Migrate agent files → global"

if [ -d "$LOCAL_AGENTS_DIR" ]; then
  for agent in "${AGENT_FILES[@]}"; do
    src="$LOCAL_AGENTS_DIR/$agent"
    dst="$GLOBAL_AGENTS_DIR/$agent"
    if [ -f "$src" ]; then
      if [ -f "$dst" ]; then
        warn "$agent already exists at global location — skipping (review manually)"
      else
        run "cp '$src' '$dst'"
        success "Migrated: $agent → global"
      fi
    else
      warn "$agent not found in local agents dir — skipping"
    fi
  done
else
  warn "Local agents directory not found: $LOCAL_AGENTS_DIR"
fi

# ── Step 4: Install consolidated skills ───────────────────────────────────────

info "Step 4: Install 12 consolidated skills → global"
info "  Source: AGENTS.md Section 2b skill table"
info "  Run this step after placing skill SKILL.md files in the repo"

# This script expects consolidated SKILL.md files to already exist at:
# $REPO_DIR/.opencode-skills-new/<skill-name>/SKILL.md
# (produced by running the companion generate-skills.sh or placed manually)

NEW_SKILLS_SOURCE="$REPO_DIR/.opencode-skills-consolidated"

if [ -d "$NEW_SKILLS_SOURCE" ]; then
  for skill in "${NEW_SKILLS[@]}"; do
    src="$NEW_SKILLS_SOURCE/$skill"
    dst="$GLOBAL_SKILLS_DIR/$skill"
    if [ -d "$src" ]; then
      run "mkdir -p '$dst'"
      run "cp '$src/SKILL.md' '$dst/SKILL.md'"
      success "Installed skill: $skill"
    else
      warn "Consolidated skill not found: $skill — create $src/SKILL.md"
    fi
  done
else
  warn "Consolidated skills source not found: $NEW_SKILLS_SOURCE"
  log "Create this directory and place SKILL.md files there, then re-run."
  log "See AGENTS.md Section 2b for the 12 skill names and descriptions."
fi

# ── Step 5: Audit old skills ──────────────────────────────────────────────────

info "Step 5: Audit old skills — mapping to consolidated names"

AUDIT_LOG="$REPO_DIR/.opencode-skill-audit.log"
$DRY_RUN || echo "# Skill consolidation audit — $(date)" > "$AUDIT_LOG"
$DRY_RUN || echo "# Old skill → New skill" >> "$AUDIT_LOG"

if [ -d "$LOCAL_SKILLS_DIR" ]; then
  for mapping in "${SKILL_MAP[@]}"; do
    old="${mapping%%:*}"
    new="${mapping##*:}"
    old_path="$LOCAL_SKILLS_DIR/$old"

    if [ -d "$old_path" ]; then
      if [ "$new" = "DELETE" ]; then
        warn "CONFLICT: $old → DELETE (contradicts Jekyll constraints)"
        log "  → Recommend deleting from .opencode/skills/$old/"
        $DRY_RUN || echo "$old → DELETED (stack conflict)" >> "$AUDIT_LOG"
      else
        log "$old → $new"
        $DRY_RUN || echo "$old → $new" >> "$AUDIT_LOG"
      fi
    else
      log "$old (not found in local skills dir)"
      $DRY_RUN || echo "$old → NOT FOUND" >> "$AUDIT_LOG"
    fi
  done

  $DRY_RUN || success "Audit log written: .opencode-skill-audit.log"
else
  warn "Local skills directory not found — skipping audit"
fi

# ── Step 6: Write opencode.json ───────────────────────────────────────────────

info "Step 6: Write .opencode/opencode.json"

run "mkdir -p '$REPO_DIR/.opencode'"

OPENCODE_JSON_CONTENT='{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "skill": {
      "*": "allow",
      "tailwind-tokens": "deny",
      "astro-components": "deny",
      "wireframing": "deny"
    },
    "bash": {
      "make build": "allow",
      "make serve": "allow",
      "bundle exec jekyll build": "allow",
      "bundle exec jekyll serve --livereload": "allow",
      "git status": "allow",
      "git log --oneline *": "allow",
      "git diff *": "allow",
      "git add *": "ask",
      "git commit *": "ask",
      "git push *": "ask",
      "*": "ask"
    }
  },
  "mcp": {
    "github": {
      "type": "url",
      "url": "https://api.githubcopilot.com/mcp/",
      "name": "github"
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest", "--headless"],
      "name": "playwright"
    }
  }
}'

if $DRY_RUN; then
  echo "  [DRY RUN] Would write opencode.json:"
  echo "$OPENCODE_JSON_CONTENT" | sed 's/^/    /'
else
  echo "$OPENCODE_JSON_CONTENT" > "$OPENCODE_JSON"
  success "Written: .opencode/opencode.json"
fi

# ── Step 7: Clean up local agents/skills dirs ─────────────────────────────────

info "Step 7: Mark local agents/skills dirs as migrated"
log "After verifying global installation, run:"
log "  rm -rf .opencode/agents/"
log "  rm -rf .opencode/skills/"
log "This keeps the repo clean — agents and skills live globally."
warn "Do NOT delete these dirs until you have verified the global install works."

# ── Step 8: Verification report ───────────────────────────────────────────────

info "Step 8: Verification report"
echo ""
echo "  Global agents:"
if [ -d "$GLOBAL_AGENTS_DIR" ]; then
  for agent in "${AGENT_FILES[@]}"; do
    if [ -f "$GLOBAL_AGENTS_DIR/$agent" ]; then
      echo "    ✅ $agent"
    else
      echo "    ❌ $agent — MISSING"
    fi
  done
else
  echo "    ❌ Directory not found: $GLOBAL_AGENTS_DIR"
fi

echo ""
echo "  Global skills (12 consolidated):"
for skill in "${NEW_SKILLS[@]}"; do
  if [ -f "$GLOBAL_SKILLS_DIR/$skill/SKILL.md" ]; then
    echo "    ✅ $skill"
  else
    echo "    ❌ $skill — MISSING"
  fi
done

echo ""
echo "  opencode.json:"
if [ -f "$OPENCODE_JSON" ]; then
  echo "    ✅ Present"
else
  echo "    ❌ Missing"
fi

echo ""
echo "══════════════════════════════════════════════════════"
echo "  Next steps:"
echo "  1. Start OpenCode: opencode"
echo "  2. Run: @ux audit https://ufawkes.dev/"
echo "  3. Run: @planning update Section 8"
echo "  4. Verify skills load: ask any agent to list available skills"
echo "  5. If all good: rm -rf .opencode/agents/ .opencode/skills/"
echo "══════════════════════════════════════════════════════"
