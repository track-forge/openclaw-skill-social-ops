#!/usr/bin/env bash
set -euo pipefail

# install-skill.sh — Copy the social-ops skill from this repo to the target directory.
# Overwrites existing files. Excludes .git and dev-only files (.clawignore pattern).
#
# Usage:
#   ./scripts/install-skill.sh [--target DIR] [--dry-run] [--include-dev]
#
# Options:
#   --target DIR     Install destination (default: ~/.openclaw/workspace/skills/social-ops)
#   --dry-run        Show what would be copied without doing it
#   --include-dev    Include dev-only files normally excluded by .clawignore

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

TARGET="${HOME}/.openclaw/workspace/skills/social-ops"
DRY_RUN=false
INCLUDE_DEV=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --include-dev)
      INCLUDE_DEV=true
      shift
      ;;
    -h|--help)
      echo "Usage: $0 [--target DIR] [--dry-run] [--include-dev]"
      echo ""
      echo "Copy the social-ops skill to the target directory."
      echo ""
      echo "Options:"
      echo "  --target DIR     Install destination (default: ~/.openclaw/workspace/skills/social-ops)"
      echo "  --dry-run        Show what would be copied without doing it"
      echo "  --include-dev    Include dev-only files normally excluded by .clawignore"
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

# Build rsync exclude list
EXCLUDES=("--exclude=.git/")

if [[ "$INCLUDE_DEV" == false ]] && [[ -f "$REPO_ROOT/.clawignore" ]]; then
  while IFS= read -r line; do
    # Skip comments and blank lines
    [[ -z "$line" || "$line" == \#* ]] && continue
    EXCLUDES+=("--exclude=$line")
  done < "$REPO_ROOT/.clawignore"
fi

RSYNC_FLAGS=(-av --delete "${EXCLUDES[@]}")

if [[ "$DRY_RUN" == true ]]; then
  RSYNC_FLAGS+=(--dry-run)
  echo "=== DRY RUN ==="
fi

echo "Source:  $REPO_ROOT/"
echo "Target:  $TARGET/"
echo ""

# Create target if it doesn't exist
if [[ "$DRY_RUN" == false ]]; then
  mkdir -p "$TARGET"
fi

rsync "${RSYNC_FLAGS[@]}" "$REPO_ROOT/" "$TARGET/"

echo ""
if [[ "$DRY_RUN" == true ]]; then
  echo "Dry run complete. No files were copied."
else
  echo "✅ Skill installed to $TARGET"
fi
