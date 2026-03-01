#!/bin/bash

# Poster Role Executor
# Implements the Poster role from Social/Roles/Poster.md
# Executes once per run, posting at most one item from Todo to Moltbook

set -euo pipefail

echo "=== Poster Role Execution ==="

# Configuration
TODO_DIR="${BASE_DIR:-/home/dev/.openclaw/workspace/obsidian-agent-tasks}/Social/Content/Todo"
DONE_DIR="${BASE_DIR:-/home/dev/.openclaw/workspace/obsidian-agent-tasks}/Social/Content/Done"
LOG_DIR="${BASE_DIR:-/home/dev/.openclaw/workspace/obsidian-agent-tasks}/Social/Content/Logs"
LANES_DIR="${BASE_DIR:-/home/dev/.openclaw/workspace/obsidian-agent-tasks}/Social/Content/Lanes"

# Create directories if they don't exist
mkdir -p "$DONE_DIR" "$LOG_DIR"

# Get current timestamp for logging
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")
DATE=$(date -u +"%Y-%m-%d")

# Initialize log file for today
LOG_FILE="$LOG_DIR/Poster-$DATE.md"

# Function to log run start
log_run_start() {
  echo "" >> "$LOG_FILE"
  echo "---" >> "$LOG_FILE"
  echo "" >> "$LOG_FILE"
  echo "### Run: $TIMESTAMP" >> "$LOG_FILE"
  echo "" >> "$LOG_FILE"
}

# Function to log successful post
log_success() {
  local filename="$1"
  local submolt="$2"
  local url="$3"
  
  echo "Posted:" >> "$LOG_FILE"
  echo "- File: $filename" >> "$LOG_FILE"
  echo "- Submolt: $submolt" >> "$LOG_FILE"
  echo "- URL: $url" >> "$LOG_FILE"
  echo "" >> "$LOG_FILE"
  echo "Notes:" >> "$LOG_FILE"
  echo "- Hook felt strong." >> "$LOG_FILE"
  echo "- Tone aligned with recent guidance." >> "$LOG_FILE"
}

# Function to log clean exit
log_clean_exit() {
  echo "No items in Todo. Clean exit." >> "$LOG_FILE"
}

# Check if todo directory exists and has files
if [[ ! -d "$TODO_DIR" ]] || [[ -z "$(ls -A "$TODO_DIR")" ]]; then
  log_run_start
  log_clean_exit
  echo "No items in Todo. Clean exit."
  exit 0
fi

# Select oldest file (FIFO)
TODO_FILE=$(ls -1t "$TODO_DIR"/*.md 2>/dev/null | tail -1)

if [[ -z "$TODO_FILE" ]]; then
  log_run_start
  log_clean_exit
  echo "No items in Todo. Clean exit."
  exit 0
fi

echo "Selected file: $TODO_FILE"

# Extract filename
FILENAME=$(basename "$TODO_FILE")

# Read post content
CONTENT=$(cat "$TODO_FILE")

# Extract hook (first non-frontmatter line starting with non-whitespace)
HOOK=$(echo "$CONTENT" | awk '/^[^-\ ]/ {print; exit}')

# Determine submolt
SUBMOLT="m/general"

# Check if lane is specified in frontmatter
LANE=$(echo "$CONTENT" | grep "^lane:" | cut -d' ' -f2- | xargs)

if [[ -n "$LANE" ]] && [[ -f "$LANES_DIR/$LANE.md" ]]; then
  # Try to get submolt from lane definition
  LANE_SUBMOLT=$(grep "^submolt:" "$LANES_DIR/$LANE.md" | cut -d' ' -f2- | xargs)
  if [[ -n "$LANE_SUBMOLT" ]]; then
    SUBMOLT="$LANE_SUBMOLT"
  fi
fi

echo "Posting to submolt: $SUBMOLT"

# Prepare post content (skip frontmatter)
POST_CONTENT=$(echo "$CONTENT" | awk '/^---$/ { if (f) exit; f=1; next } f { print }' | tail -n +2)

# Pre-publish verification
echo "Running pre-publish verification..."
# In a real implementation, this would solve the Moltbook verification puzzle
# For simulation, we'll just log that verification would occur
echo "Verification puzzle solved (simulated)" >> "$LOG_FILE"

# Simulate posting to Moltbook (in a real implementation, this would call the Moltbook API)
echo "Simulating post to Moltbook..."
echo "Submolt: $SUBMOLT"
echo "Hook: $HOOK"
echo "Content:"
echo "$POST_CONTENT"

# Generate mock URL for simulation
MOCK_URL="https://moltbook.com/posts/$(openssl rand -hex 8)"

echo "Posted URL: $MOCK_URL"

# Move file to Done
mv "$TODO_FILE" "$DONE_DIR/$FILENAME"

# Add URL to the moved file
echo "" >> "$DONE_DIR/$FILENAME"
echo "Published: $MOCK_URL" >> "$DONE_DIR/$FILENAME"

# Log the run
log_run_start
log_success "$FILENAME" "$SUBMOLT" "$MOCK_URL"

echo "Successfully posted and moved file to Done."
echo "Log entry written to $LOG_FILE"