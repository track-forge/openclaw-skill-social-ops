# Path Conventions ({baseDir} + Workspace)

This project uses two path classes.

## 1) Skill-owned files → `{baseDir}`

Use `{baseDir}` for paths that are part of this skill repository:

- `SKILL.md`
- `references/**`
- `assets/**`
- `scripts/**`
- `docs/**`

Examples:

- `{baseDir}/references/roles/Scout.md`
- `{baseDir}/assets/strategy/Social-Networking-Plan.md`
- `{baseDir}/references/ROLE-IO-MAP.md`

`{baseDir}` is resolved by the OpenClaw skill loader at runtime to the installed skill directory.

## 2) Runtime operational data

Use these locations for role runtime artifacts generated during operation:

- Social runtime data lives in the workspace (outside the installed skill directory):
  - `<workspace>/Social/Guidance/**`
  - `<workspace>/Social/Content/Todo/**`
  - `<workspace>/Social/Content/Done/**`
  - `<workspace>/Social/Content/Logs/**`
- Comment watermark state remains at:
  - `{baseDir}/../state/comment-state.json`

`Social/` is intentionally workspace-scoped to avoid data loss during skill updates.

## Rule for future edits

- Do not introduce absolute host paths.
- For packaged skill references, prefer `{baseDir}`.
- For generated Social runtime artifacts, keep paths under `<workspace>/Social/...`.
- For known state artifacts, use the documented state path until policy changes.
