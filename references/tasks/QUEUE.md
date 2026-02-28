# Social Ops Small Task Queue

This queue is designed for cron-driven builder/implementation passes.

## Pickup Rules (deterministic)

1. Pick the first task in **Todo**.
2. Move it to **In Progress** and add `started_at` + `run_id`.
3. Complete only that task unless it is blocked.
4. Move to **Done** with `completed_at`, `result`, and changed files.
5. If blocked, move to **Blocked** with a short blocker note.

## Todo

- [ ] TASK-ID: SOT-001
  title: Define first cron pickup task for role-doc normalization
  type: docs
  priority: high
  owner: unassigned
  created_at: 2026-02-24
  depends_on: none
  definition_of_done:
    - one role doc is normalized to remove adapter-specific API flow details
    - role doc links to adapter note path instead

## In Progress

<!-- move active tasks here during a run -->

## Blocked

<!-- place blocked tasks here with blocker note -->

## Done

### SOT-009: Implement Responder role automation script

Status: `done`
Date: 2026-02-28
Owner: Builder
Result: Implemented the Responder role automation script according to Social/Roles/Responder.md specifications.
Changed files:
- `scripts/responder.sh` (new)
- `references/tasks/SOT-009.md` (new)

### SOT-007: Implement Poster Role Automation Script

Status: `done`
Date: 2026-02-27
Owner: Builder
Result: Created bash script implementing Poster role logic including FIFO selection, submolt determination, file management, and logging.
Changed files:
- `scripts/poster.sh` (new)
- `references/tasks/SOT-007.md` (new)

### SOT-008: Create cron job configuration for automated poster execution

Status: `done`
Date: 2026-02-27
Owner: Builder
Result: Created cron job configuration for the Poster role automation script with proper scheduling and environment setup.
Changed files:
- `scripts/poster-cron.conf` (new)
- `references/tasks/SOT-008.md` (new)
