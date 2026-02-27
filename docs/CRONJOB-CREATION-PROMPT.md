# Cronjob Creation Prompt for Social-Media Roles

This document provides a reusable template for creating the baseline social-media cron jobs for the social-ops skill. Users can copy and customize this prompt to set up automated execution of all six social-media roles.

## Baseline Cron Set

### Prerequisites

Before setting up these cron jobs, ensure:
1. The social-ops skill is installed and accessible
2. All required dependencies are available
3. The BASE_DIR environment variable is set to your workspace root
4. The Moltbook API credentials are properly configured

### Cron Job Template

```
# ================================
# Social-Media Role Cron Baseline
# ================================

# Environment variables
BASE_DIR=/home/dev/.openclaw/workspace/obsidian-agent-tasks

# 1) Moltbook Poster
# Schedule: 0 9,13,17,21 * * *
# TZ: America/New_York
0 9,13,17,21 * * * dev cd {baseDir} && BASE_DIR="$BASE_DIR" ./scripts/poster.sh >> /var/log/social-ops-poster.log 2>&1

# 2) Moltbook Responder
# Schedule: 15 8,11,14,17,20,23 * * *
# TZ: America/New_York
15 8,11,14,17,20,23 * * * dev cd {baseDir} && BASE_DIR="$BASE_DIR" ./scripts/responder.sh >> /var/log/social-ops-responder.log 2>&1

# 3) Moltbook Scout
# Schedule: 30 8,19 * * *
# TZ: America/New_York
30 8,19 * * * dev cd {baseDir} && BASE_DIR="$BASE_DIR" ./scripts/scout.sh >> /var/log/social-ops-scout.log 2>&1

# 4) Moltbook Content Specialist
# Schedule: 0 1 * * *
# TZ: America/New_York
0 1 * * * dev cd {baseDir} && BASE_DIR="$BASE_DIR" ./scripts/content-specialist.sh >> /var/log/social-ops-content-specialist.log 2>&1

# 5) Moltbook Researcher
# Schedule: 0 2 * * 2,5
# TZ: America/New_York
0 2 * * 2,5 dev cd {baseDir} && BASE_DIR="$BASE_DIR" ./scripts/researcher.sh >> /var/log/social-ops-researcher.log 2>&1

# 6) Moltbook Analyst
# Schedule: 0 19 * * 0
# TZ: America/New_York
0 19 * * 0 dev cd {baseDir} && BASE_DIR="$BASE_DIR" ./scripts/analyst.sh >> /var/log/social-ops-analyst.log 2>&1
```

## Customization Guide

### Tuning Cadence

To adjust the frequency of any role's execution:

1. Modify the cron schedule expression (first 5 fields)
2. Maintain the role's core constraints:
   - Poster: Maximum 1 post per run
   - Responder: Meaningful engagement only
   - Scout: Max 3 opportunities per run
   - Content Specialist: Consistent with lane strategy
   - Researcher: 1-3 tasks per run
   - Analyst: Weekly minimum

### Path Customization

Replace `{baseDir}` with the actual path to your social-ops skill installation.

### Log File Management

Consider setting up log rotation for the output files:
- /var/log/social-ops-poster.log
- /var/log/social-ops-responder.log
- /var/log/social-ops-scout.log
- /var/log/social-ops-content-specialist.log
- /var/log/social-ops-researcher.log
- /var/log/social-ops-analyst.log

## Installation Instructions

1. Save the template to a file (e.g., `social-ops-cron.conf`)
2. Modify paths and environment variables as needed
3. Install the cron file:
   ```bash
   sudo cp social-ops-cron.conf /etc/cron.d/social-ops
   sudo chown root:root /etc/cron.d/social-ops
   sudo chmod 644 /etc/cron.d/social-ops
   ```
4. Verify the cron jobs are loaded:
   ```bash
   sudo crontab -l
   ```

## Validation

After installation, verify that:
1. All cron jobs appear in the crontab
2. Scripts are executable
3. Log files are being created
4. No errors appear in system logs