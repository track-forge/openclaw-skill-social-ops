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

## 2) Runtime operational data → workspace-relative

Use workspace-relative paths for role runtime artifacts generated during operation:

- `Social/Guidance/**`
- `Social/Content/Todo/**`
- `Social/Content/Done/**`
- `Social/Content/Logs/**`
- `state/comment-state.json`

These are intentionally not in skill package paths because they are mutable user/runtime data.

## Scan Outcome (Issue #18)

- No machine-specific absolute path references remain in repository docs.
- `SKILL.md` now uses `{baseDir}` for all skill-owned references.
- Role docs continue to use `Social/...` and `state/...` for runtime artifacts by design.

## Rule for future edits

- Do not introduce absolute host paths.
- For packaged skill references, prefer `{baseDir}`.
- For generated runtime artifacts, keep workspace-relative paths.
