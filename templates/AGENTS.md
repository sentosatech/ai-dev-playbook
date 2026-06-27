# Agent Instructions

Follow these rules when working in this repo.

## Operating Model

- Preserve human control of architecture, public contracts, interfaces, and major
  implementation tradeoffs.
- Read `PROJECT_CONTEXT.md` before substantial work.
- Follow `process.md` for non-trivial changes.
- Prefer existing repo conventions over generic advice.
- Keep changes scoped to the requested work.

## Approval Gates

Stop for human approval before implementing changes that affect:

- public behavior
- APIs, RPCs, SDKs, CLI contracts, or tool contracts
- data shapes or schemas
- persistence or artifact layouts
- runtime boundaries
- architecture or portability decisions

Record approval in durable artifacts. Chat-only approval is not enough for work
that continues across sessions.

## Verification

Before closeout, run the verification path documented in `PROJECT_CONTEXT.md`.
If `scripts/verify` exists, use the appropriate profile:

- `quick` for normal changes
- `smoke` when runtime or workflow sanity matters
- `full` for risky or architecture-sensitive changes

If verification cannot be run, say so clearly and explain what remains
unverified.
