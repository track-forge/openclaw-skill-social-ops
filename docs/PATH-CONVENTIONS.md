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

## 2) Runtime operational data → workspace-relative

Use paths relative to the `{baseDir}` parent for role runtime artifacts generated during operation:

- `../Social/Guidance/**`
- `../Social/Content/Todo/**`
- `../Social/Content/Done/**`
- `../Social/Content/Logs/**`
- `../state/comment-state.json`

These are intentionally not in skill package paths because they are mutable user/runtime data.

## Rule for future edits

- Do not introduce absolute host paths.
- For packaged skill references, prefer `{baseDir}`.
- For generated runtime artifacts, keep `{baseDir}`-relative parent paths (for example `../Social/...`).
