# Process

Use this five-move process for non-trivial AI-assisted work.

```text
Frame
  -> Contract + approve
  -> Architecture + approve
  -> Slice + approve
  -> Build + Verify + Close
```

## Frame

Clarify the goal, constraints, affected area, and likely risk.

## Contract + Approve

Use this gate for public behavior, APIs, RPCs, SDKs, CLI contracts, tool
contracts, schemas, or generated artifacts.

Record approval durably before implementation.

## Architecture + Approve

Use this gate for runtime boundaries, persistence, package boundaries, service
boundaries, portability, performance, or major technology choices.

Record approval durably before implementation.

## Slice + Approve

Define the implementation slice, likely files, verification profile, and done
criteria.

## Build + Verify + Close

Implement the approved slice, run verification, update project memory, and
report the outcome.

Closeout requires:

- approval recorded where required
- code/docs/specs match the approved plan
- relevant tests or validation updated when practical
- verification run or explicitly reported as unavailable
- project state/history updated when needed
