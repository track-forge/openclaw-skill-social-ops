# Social Ops Small Task Queue

Deterministic queue for cron-driven builder passes.

## Task Entry Schema

Each task entry must include:

- `id` (e.g., `SOT-004`)
- `title`
- `status` (`todo` | `in-progress` | `blocked` | `done`)
- `priority` (`high` | `medium` | `low`)
- `owner` (agent handle or `unassigned`)
- `created_at` (UTC date)
- `acceptance_criteria` (checklist)
- `links` (issue/PR/docs)

Optional fields:
- `depends_on`
- `started_at`
- `completed_at`
- `run_id`
- `blocker`
- `result`
- `changed_files`

## Allowed Statuses

- `todo` — ready for pickup
- `in-progress` — currently being executed
- `blocked` — cannot proceed until blocker is cleared
- `done` — completed and validated

## Selection Rules (cron pickup)

1. Select from tasks with `status: todo`.
2. Sort by `priority` (`high` > `medium` > `low`).
3. Tie-break by oldest `created_at`.
4. Final tie-break by lowest lexical `id`.
5. Pick exactly one task per pass.

## Handoff / Update Rules

1. Move selected task to `status: in-progress`; set `started_at` + `run_id`.
2. Execute only that task unless it is blocked.
3. On success: set `status: done` and add `completed_at`, `result`, and `changed_files`.
4. On blocked: set `status: blocked` and add concise `blocker` note.
5. Leave untouched tasks unchanged for deterministic next pickup.

## Tasks

### Todo

- id: SOT-005
  title: Add adapter-note placeholders for role docs that still include platform-specific run details
  status: todo
  priority: medium
  owner: unassigned
  created_at: 2026-02-25
  acceptance_criteria:
    - create adapter note placeholders under `references/adapters/`
    - link at least one role doc to the corresponding adapter note
    - keep role behavior docs platform-agnostic
  links:
    - issue: https://github.com/track-forge/openclaw-skill-social-ops/issues/5

- id: SOT-006
  title: Add queue-consumption guidance section to SKILL.md
  status: todo
  priority: low
  owner: unassigned
  created_at: 2026-02-25
  acceptance_criteria:
    - include a short "cron pickup" section in `SKILL.md`
    - point to queue rules and task template
  links:
    - doc: SKILL.md
    - doc: references/tasks/TEMPLATE.md

### In Progress

<!-- move active task here during execution -->

### Blocked

<!-- blocked task entries go here with blocker notes -->

### Done

- id: SOT-001
  title: Define first cron pickup task for role-doc normalization
  status: done
  priority: high
  owner: builder
  created_at: 2026-02-24
  started_at: 2026-02-24T23:56:00Z
  completed_at: 2026-02-24T23:56:50Z
  run_id: builder-pass-2026-02-24-2356z
  acceptance_criteria:
    - one role doc is normalized to remove adapter-specific API flow details
    - role doc links to adapter note path instead
  links:
    - project: /home/dev/.openclaw/workspace/obsidian-agent-tasks/Projects/Social-Ops-Skill-Build.md
  result: Queue scaffolding and deterministic task template established for future passes.
  changed_files:
    - references/tasks/QUEUE.md
    - references/tasks/TEMPLATE.md
    - references/tasks/README.md

- id: SOT-004
  title: Define deterministic queue spec for cron-friendly small-task pickups
  status: done
  priority: high
  owner: builder
  created_at: 2026-02-25
  started_at: 2026-02-25T14:26:00Z
  completed_at: 2026-02-25T14:34:00Z
  run_id: issue-4-one-shot-2026-02-25
  acceptance_criteria:
    - document queue schema, statuses, selection, and handoff rules
    - include at least three example task entries
    - link queue from skill-facing docs
  links:
    - issue: https://github.com/track-forge/openclaw-skill-social-ops/issues/4
  result: Expanded queue spec to deterministic, reusable format with explicit task schema and examples.
  changed_files:
    - references/tasks/QUEUE.md
    - SKILL.md
    - references/README.md
