# ClawHub Publish Checklist

> Everything needed to ship `social-ops` v0.1.0 on [clawhub.com](https://clawhub.com).

## Prerequisites

### 1. Auth
- [ ] Run `clawhub login` — opens browser for OAuth
- [ ] Verify with `clawhub whoami`
- **Who?** Whoever owns the ClawHub account for track-forge. If no account exists yet, one of us (dk/dougbtv) needs to create one at clawhub.com.
- **⚠️ Unknown:** Does ClawHub support org-level publishing, or is it user-scoped? Need to verify.

### 2. Required File: `SKILL.md`
ClawHub publishes from a folder. The only **required** file is `SKILL.md` with YAML frontmatter:

```yaml
---
name: social-ops           # Must match --slug (or becomes the slug)
description: >             # One-liner shown in search results
  Role-based social media operations skill...
---
```

**Current status:** ✅ Our `SKILL.md` already has valid frontmatter with `name` and `description`.

### 3. File Structure
ClawHub publishes **all files in the folder** (minus `.git/`, `.github/`, etc.). The publish command walks the directory tree.

Our current tree:
```
SKILL.md                          ✅ Required
README.md                         ✅ Good — context for users
AGENTS.md                         ⚠️ Review — contains internal contributor notes
LICENSE                            ✅ Keep
assets/strategy/                   ✅ Strategy docs referenced by roles
references/roles/*.md              ✅ Core role definitions
references/tasks/QUEUE.md          ⚠️ Review — contains WIP task state
references/tasks/TEMPLATE.md       ✅ Reusable template
references/ROLE-IO-MAP.md          ✅ Workflow documentation
.github/                           🔵 Won't be published (dotfile)
.pre-commit-config.yaml            🔵 Won't be published (dotfile)
```

### 4. Publish Command

```bash
clawhub publish ./path-to-skill \
  --slug social-ops \
  --name "Social Ops" \
  --version 0.1.0 \
  --changelog "Initial release: 6-role social operations framework (Scout, Researcher, Content Specialist, Responder, Poster, Analyst). Role I/O map, strategy assets, task queue template."
```

### 5. Versioning
- Semver required (`--version X.Y.Z`)
- `v0.1.0` = first public release (pre-1.0, signals "usable but evolving")
- Future: bump minor for new roles/features, patch for fixes
- Tags default to `latest`; can add custom tags

## Pre-Publish Validation Checklist

- [ ] **SKILL.md frontmatter** — `name` and `description` present and accurate
- [ ] **No secrets/tokens** in any file (TruffleHog CI covers this via PR #11)
- [ ] **No hardcoded usernames/personas** — GladeRunner-specific references should be parameterized or documented as examples
- [ ] **QUEUE.md** cleaned — remove WIP task state, leave as empty template or remove
- [ ] **AGENTS.md** reviewed — decide: include (useful for contributors) or exclude (internal-only)
- [ ] **README.md** includes install instructions: `clawhub install social-ops`
- [ ] **All role docs** are self-contained and reference relative paths correctly
- [ ] **Strategy doc** is generic enough for reuse (or documented as an example)
- [ ] **LICENSE** file present (currently AGPL-3.0)

## v0.1.0 Scope

**In scope:**
- 6 role definitions (Scout, Researcher, Content Specialist, Responder, Poster, Analyst)
- Role I/O map documenting handoffs
- Strategy template/example
- Task queue template
- Directory contract

**Out of scope (post-v0.1.0):**
- Platform adapters (Moltbook, Twitter, Discord, etc.)
- Scripts/automation helpers
- Metrics collection tooling
- Multi-agent dispatch orchestration

## Unknowns & Risks

| # | Unknown | Impact | Mitigation |
|---|---------|--------|------------|
| 1 | **Org publishing** — ClawHub may be user-scoped only. No "track-forge" org concept. | Skill owned by one person's account | Publish under shared account, or accept single-owner for now |
| 2 | **Dotfile filtering** — Unclear if `.github/`, `.pre-commit-config.yaml` are auto-excluded | CI config leaked into published skill | Test with `--dry-run` if available, or inspect after publish |
| 3 | **File size limits** — Unknown max per file or total | Could block publish if strategy doc is large | Our files are small (<15KB each), likely fine |
| 4 | **Auth account** — Nobody has run `clawhub login` yet | Can't publish without auth | Need dk or dougbtv to auth before publish |
| 5 | **GladeRunner-specific content** — Strategy doc references GladeRunner persona | Limits reusability for other users | Document as "example persona" or parameterize |

## Follow-Up Issues (to create after spike)

1. **Clean repo for publish** — Remove/template WIP state in QUEUE.md, review AGENTS.md, ensure no persona-specific hardcoding blocks reuse
2. **Add install instructions to README** — `clawhub install social-ops`, quick-start guide for new users
3. **Auth + first publish** — Run `clawhub login`, execute publish command, verify listing on clawhub.com
4. **Post-publish: platform adapters** — Issue for adding Moltbook/Twitter/Discord adapter scripts (v0.2.0)
