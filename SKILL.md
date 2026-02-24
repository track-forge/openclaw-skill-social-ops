# social-ops

Role-based social operations skill for OpenClaw agents.

## What this skill does

`social-ops` separates social execution into explicit roles so runs stay focused,
reviewable, and composable.

Core roles:
- Scout
- Responder
- Researcher
- Content Specialist
- Poster
- Analyst

## Flow (high-level)

Scout -> Content Specialist / Responder
Researcher -> Guidance
Content Specialist -> Poster
Poster -> Done logs
Analyst -> Strategy adjustments

## Directory contract

- `references/` - role and strategic references used by the skill.
  - `references/roles/` - role docs (normalized from source assets)
- `assets/` - imported strategy artifacts and static source material
  - `assets/strategy/` - strategic north-star documents
- `scripts/` - optional helper scripts/adapters used by execution runs

## References

- Strategy basis: `assets/strategy/Social-Networking-Plan.md`
- Role docs:
  - `references/roles/Scout.md`
  - `references/roles/Responder.md`
  - `references/roles/Researcher.md`
  - `references/roles/Content-Specialist.md`
  - `references/roles/Poster.md`
  - `references/roles/Analyst.md`

## Notes

This is an initial skeleton focused on packaging structure and role boundaries.
Detailed runbooks and adapter implementation can be layered in incrementally.
