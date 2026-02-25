# Role Input/Output Map

This document maps how data moves between roles in `social-ops`.

Use it to:
- understand role handoffs
- see which artifacts are read/written by each role
- audit logging coverage

## Canonical workflow

```text
Scout ──┬─> Content Specialist ──> Poster
        └─> Responder

Researcher ──> Guidance ──> Content Specialist + Poster (+ Analyst for review context)

Poster + Scout + Responder + Researcher outputs ──> Analyst
Analyst recommendations ──> Content Specialist + Researcher
```

## Role-by-role I/O

## Scout
- Reads:
  - Moltbook feed/submolts/accounts (platform data)
- Writes:
  - `Social/Content/Logs/Scout-YYYY-MM-DD.md`
- Primary consumers:
  - Responder (thread insertion opportunities)
  - Content Specialist (topic opportunities)
  - Researcher (trend follow-up)

## Researcher
- Reads:
  - Moltbook high-performing posts/accounts
  - `Social/Guidance/Research-Tasks.md` (task queue)
  - prior research logs
- Writes:
  - `Social/Guidance/README.md` (durable guidance)
  - `Social/Guidance/Research-Tasks.md` (task queue updates)
  - `Social/Content/Logs/Research-YYYY-MM-DD.md`
- Primary consumers:
  - Content Specialist (content planning)
  - Poster (tone/check alignment)
  - Analyst (pattern validation over time)

## Content Specialist
- Reads:
  - `Social/Guidance/README.md`
  - `Social/Content/Lanes/`
  - `Projects/`
  - `Creative/`
  - `Reference/Reddit/`
  - recent `Social/Content/Logs/Research-YYYY-MM-DD.md`
- Writes:
  - `Social/Content/Todo/YYYY-MM-DD-XX-LaneName.md`
  - `Social/Content/Lanes/*.md` (create/refine/retire lane definitions)
  - `Social/Content/Logs/Content-YYYY-MM-DD.md`
- Primary consumers:
  - Poster (publishes TODO items)
  - Analyst (evaluates lane/post pipeline performance)

## Poster
- Reads:
  - `Social/Guidance/README.md`
  - `Social/Content/Todo/`
  - `Social/Content/Lanes/`
- Writes:
  - `Social/Content/Done/` (moves posted file from Todo)
  - `Social/Content/Logs/Poster-YYYY-MM-DD.md`
  - published post URL attached to moved post artifact
- Primary consumers:
  - Analyst (performance review)
  - Responder (reply surface from posted content)

## Responder
- Reads:
  - Moltbook replies/DMs/mentions
  - `state/comment-state.json`
  - latest Scout log: `Social/Content/Logs/Scout-YYYY-MM-DD.md`
- Writes:
  - `state/comment-state.json` (watermarks + seen ids)
  - `Social/Content/Logs/Responder-YYYY-MM-DD.md`
- Primary consumers:
  - Analyst (relational signal quality)

## Analyst
- Reads:
  - `Social/Content/Done/`
  - `Social/Content/Logs/Poster-YYYY-MM-DD.md`
  - `Social/Content/Logs/Responder-YYYY-MM-DD.md`
  - `Social/Content/Logs/Scout-YYYY-MM-DD.md`
  - `Social/Content/Logs/Research-YYYY-MM-DD.md`
  - Moltbook engagement metrics
- Writes:
  - `Social/Content/Logs/Analysis-YYYY-WW.md`
  - recommendations (consumed by Content Specialist + Researcher)
- Primary consumers:
  - Content Specialist (lane/cadence changes)
  - Researcher (new research focus)

## Shared artifact map

- Guidance artifacts:
  - `Social/Guidance/README.md` (producer: Researcher; consumers: Content Specialist, Poster, Analyst)
  - `Social/Guidance/Research-Tasks.md` (producer/consumer: Researcher)

- Pipeline artifacts:
  - `Social/Content/Todo/` (producer: Content Specialist; consumer: Poster)
  - `Social/Content/Done/` (producer: Poster; consumer: Analyst)
  - `Social/Content/Lanes/` (producer: Content Specialist; consumers: Poster, Analyst)

- Log artifacts:
  - `Social/Content/Logs/Scout-YYYY-MM-DD.md` (producer: Scout; consumers: Responder, Analyst)
  - `Social/Content/Logs/Research-YYYY-MM-DD.md` (producer: Researcher; consumers: Content Specialist, Analyst)
  - `Social/Content/Logs/Content-YYYY-MM-DD.md` (producer: Content Specialist; consumer: Analyst)
  - `Social/Content/Logs/Poster-YYYY-MM-DD.md` (producer: Poster; consumer: Analyst)
  - `Social/Content/Logs/Responder-YYYY-MM-DD.md` (producer: Responder; consumer: Analyst)
  - `Social/Content/Logs/Analysis-YYYY-WW.md` (producer: Analyst; consumers: Content Specialist, Researcher)

- Runtime state artifacts:
  - `state/comment-state.json` (producer/consumer: Responder)

## Notes

- Paths above intentionally preserve current role-doc conventions, even when they reference notebook paths outside this repository.
- As adapter abstractions are introduced, update this map first, then update role docs to keep handoffs explicit.
