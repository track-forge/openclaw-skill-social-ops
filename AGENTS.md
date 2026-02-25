# AGENTS.md

Guidelines for agents contributing to `openclaw-skill-social-ops`.

This repository is intended to be maintained via disciplined, reviewable changes.
Agents must follow the rules below.

---

## 1. Branching Rules

Agents must never commit directly to `main`.

All changes must be made on feature branches using the naming pattern:

```

dev/<short-description>

```

Examples:

- `dev/add-platform-adapter-interface`
- `dev/refactor-scout-routing`
- `dev/update-readme-structure`

Branch names should be:

- Lowercase
- Hyphen-separated
- Descriptive but concise

---

## 2. Pull Request Workflow

All changes must go through a Pull Request (PR).

Requirements:

- At least one approval before merging.
- No self-approval.
- PR description must explain:
  - What changed
  - Why it changed
  - Which role or subsystem is affected
  - Any follow-up implications

Agents must not merge their own PRs without approval unless explicitly authorized.

---

## 3. Scope Discipline

Agents must:

- Modify only the files relevant to the task.
- Avoid broad refactors unless explicitly requested.
- Preserve role boundaries defined in the skill.
- Avoid introducing cross-role coupling.

This repository encodes separation of concerns.
Do not blur it.

---

## 4. Logging Changes

If modifying:

- Role definitions
- Feedback loops
- Execution flow
- Cron recommendations
- Guidance structure

The PR must explicitly state how the change affects the feedback loop.

We optimize for compounding systems.
Structural changes must be deliberate.

---

## 5. No Platform Lock-In

This skill is platform-agnostic.

Agents must not:

- Hardcode Moltbook-specific logic into core architecture.
- Introduce assumptions about a single platform.

Platform adapters must be modular.

---

## 6. Incremental Improvement

Agents should prefer:

- Small, reviewable changes
- Clear diffs
- Forward-compatible structure

Avoid sweeping redesigns without discussion.

---

## 7. Security & Safety

Agents must not:

- Embed secrets
- Hardcode API keys
- Introduce automation that bypasses platform terms
- Add spam-oriented growth tactics

This is a reputation system, not a growth-hack toolkit.

---

## 8. Documentation First

If adding new capability:

- Update README if externally visible.
- Update role docs if behavior changes.
- Keep architecture understandable.

Clarity compounds.

---

## 9. When in Doubt

Open a draft PR.
Explain the uncertainty.
Request human review.

This repository values stability over speed.
