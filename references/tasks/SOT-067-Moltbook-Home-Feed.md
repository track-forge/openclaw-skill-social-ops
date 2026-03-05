---
task_id: SOT-067
title: Integrate Moltbook /home Endpoint into Social-Ops Flow
status: done
priority: normal
created: 2026-03-05
related_issues:
  - "#67"
---

# Task: Integrate Moltbook `/home` Endpoint

## Objective

Ensure the Moltbook `/home` endpoint is first-class in the social-ops
architecture, primarily for the Scout role and optionally for Researcher and
Analyst, without introducing platform lock-in or leaking raw feed data into
logs.

## Scope

- Add a single reference document that defines how `/home` should be used by
  roles.
- Wire Scout, Researcher, and Analyst role docs to this reference.
- Preserve the existing directory and logging contracts.

## Implementation Summary

- Added `{baseDir}/references/MOLTBOOK-HOME-FEED.md` as the canonical guidance
  for `/home` usage across roles.
- Updated `{baseDir}/references/roles/Scout.md` to:
  - Treat `/home` (via the Moltbook skill) as the primary input feed.
  - Point to the new reference doc for concrete integration details.
- Updated `{baseDir}/references/roles/Researcher.md` to:
  - Optionally sample `/home` when researching **current, emergent patterns**.
- Updated `{baseDir}/references/roles/Analyst.md` to:
  - Optionally use a light `/home` sample as context for weekly analysis.

## Acceptance Tests

These are **manual validation steps** for agents and maintainers.

### Scout

1. Read `{baseDir}/references/roles/Scout.md`.
2. Confirm that:
   - `/home` is listed as the primary Moltbook input feed.
   - The doc points to `{baseDir}/references/MOLTBOOK-HOME-FEED.md`.
3. In a dry-run Scout execution, ensure that:
   - The run starts from the `/home` feed via the Moltbook skill.
   - Only a small, fixed slice of `/home` is inspected.
   - At most **3** opportunities are logged.
   - Logs in `$SOCIAL_OPS_DATA_DIR/Content/Logs/Scout-YYYY-MM-DD.md` contain
     **summaries only**, with no raw `/home` payloads.

### Researcher

1. Read `{baseDir}/references/roles/Researcher.md`.
2. Confirm that:
   - `/home` is described as an **optional** sampling source for emergent
     pattern research.
   - The doc points (directly or indirectly) to the `/home` reference.
3. In a dry-run Researcher execution focused on current patterns, ensure that:
   - At most one slice of `/home` is sampled to select candidate posts.
   - Detailed analysis still happens on specific submolts or authors.
   - Only distilled patterns are written to
     `$SOCIAL_OPS_DATA_DIR/Guidance/README.md` and
     `$SOCIAL_OPS_DATA_DIR/Content/Logs/Research-YYYY-MM-DD.md`.

### Analyst

1. Read `{baseDir}/references/roles/Analyst.md`.
2. Confirm that:
   - `/home` is treated as **context only**, not as a primary metrics source.
   - The doc points to the `/home` reference for details.
3. In a dry-run Analyst execution, ensure that:
   - At most one `/home` sample is used to understand what Moltbook is
     surfacing during the analysis window.
   - Weekly log files at
     `$SOCIAL_OPS_DATA_DIR/Content/Logs/Analysis-YYYY-WW.md` summarize
     observations instead of copying raw feed items.

## Done When

- Role docs build against the new `/home` reference without breaking existing
  path contracts.
- Manual runs of Scout, Researcher, and Analyst can be performed that:
  - Start from `/home` where appropriate.
  - Keep `/home` usage bounded and summarized.
  - Do not log raw responses or private content.
