# Human Configuration Guide for Social Ops Skill

This guide helps users configure the social-ops skill for their specific needs and content.

## Overview

The social-ops skill is designed to be flexible and adaptable to different content sources, social media goals, and operational guardrails. This guide walks you through the key configuration points.

## 1. Content Directories

The skill operates on content directories that contain your social media materials. By default, these are located in your OpenClaw workspace under `Social/`.

### Default Structure

```
<workspace>/Social/
├── Content/
│   ├── Lanes/       # Lane definitions
│   ├── Todo/        # Pending posts
│   ├── Done/        # Published posts
│   └── Logs/        # Activity logs
├── Guidance/        # Strategy and tone guidance
└── State/           # Runtime state files
```

### Customizing Content Paths

You can customize these paths by setting environment variables or modifying the skill's configuration. The skill uses `{baseDir}/../Social/` as the default root, but you can adjust this to point to any directory structure that matches the expected layout.

## 2. Social Media Goals

Define your social media goals in `<workspace>/Social/Guidance/README.md`. This file should include:

- Target audience
- Desired tone and voice
- Key messaging themes
- Growth objectives
- Platform-specific considerations

The Content Specialist and Writer roles will reference this file when creating content.

## 3. Guardrails and Rules

Establish clear guardrails in `<workspace>/Social/Guidance/Guardrails.md`:

- What topics to avoid
- What language is inappropriate
- Privacy and confidentiality rules
- Brand guidelines
- Legal compliance requirements

All roles should be aware of and遵守 these guardrails.

## 4. Content Specialist Workflow

The Content Specialist role is designed to work with user-provided content directories:

1. It can inspect content directories to understand available materials
2. It can suggest lane structures based on content themes
3. It can identify gaps in content coverage
4. It can propose content strategies based on analysis

To enable this functionality:
- Ensure your content directories are accessible to the skill
- Provide clear documentation about content organization
- Specify any preferred categorization or tagging schemes

## 5. Initial Setup Script

Consider creating a setup script that guides users through the initial configuration:

```bash
./configure-social-ops.sh
```

This script could:
- Prompt for content directory locations
- Help define initial social media goals
- Set up the basic directory structure
- Create template guidance files
- Install cron jobs for automated execution

## 6. Validation

After configuration, validate that:
- All required directories exist and are writable
- Guidance files are in place
- The skill can access content directories
- Cron jobs are properly scheduled
- All roles can execute without errors

Regular validation ensures the system continues to operate smoothly as content and goals evolve.