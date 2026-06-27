# Agent Process

This document defines the human-plus-agent workflow for AI-assisted development.

The process is intentionally small:

```text
Frame
  -> Contract + approve
  -> Architecture + approve
  -> Slice + approve
  -> Build + Verify + Close
```

The human engineer owns architecture, tradeoffs, boundaries, interfaces,
approval, and judgment. The agent drafts options, records decisions, implements
approved work, runs verification, and keeps context current.

## Frame

Clarify the request, goal, constraints, and affected area.

For small internal changes, the process may fast-path directly to Build + Verify
+ Close if there is no public behavior, contract, architecture, or workflow
change.

## Contract + Approve

Use this gate when the work affects public behavior, inputs, outputs, artifacts,
agent-callable tools, APIs, CLI behavior, RPC calls, schemas, or SDK surfaces.

Expected output:

- spec or contract draft
- important input/output shapes
- success and failure behavior
- verification expectations
- approval recorded in durable metadata

Do not implement contract-sensitive work until the contract is approved.

## Architecture + Approve

Use this gate when the work affects runtime boundaries, persistence, package
boundaries, service boundaries, deployment assumptions, performance, portability,
security, or major technology choices.

Expected output:

- current design update, ADR, or architecture note
- tradeoffs considered
- selected approach
- approval recorded durably

Do not let the agent make expensive-to-reverse architecture choices without
human approval.

## Slice + Approve

Turn approved contract and architecture into a small implementation slice.

Expected output:

- issue/work item
- files or modules likely to change
- verification profile to run
- done criteria

## Build + Verify + Close

Implement the approved slice, run verification, update project memory, and report
the outcome.

### Verification Triggers

Before closeout:

1. Read the repo's verification instructions in `AGENTS.md`,
   `PROJECT_CONTEXT.md`, or `process.md`.
2. If `scripts/verify` exists, run the appropriate profile:
   - `quick` for normal changes
   - `smoke` when runtime or workflow sanity matters
   - `full` for risky, public-contract, release, or architecture-sensitive work
3. If no verification path exists, say that clearly.
4. Never claim verification passed unless it was actually run.

Manual verification is fallback behavior. If automated verification is not
available, report what manual inspection is needed or what was inspected.

### Definition Of Done

For normal implementation work, closeout requires:

- approved contract when public behavior, data shapes, or interfaces changed
- approved architecture when runtime boundaries, storage, APIs, RPCs, SDKs, or
  major tradeoffs changed
- code/docs/specs updated to match the approved plan
- relevant tests or validation artifacts added or updated when practical
- verification run with the appropriate profile, or a clear explanation of why
  verification could not be run
- `PROJECT_CONTEXT.md`, `.ai/project-state.yaml`, and `docs/change-log.md`
  updated when the change affects project state or durable history

## Fast Path

The fast path is allowed for narrow internal changes such as typo fixes, small
test additions, local refactors, or docs cleanup.

Fast path still requires:

- understanding the local context
- preserving existing architecture
- running or reporting verification
- clear final summary

Fast path is not allowed when changing public behavior, contracts, architecture,
runtime boundaries, data shapes, or verification expectations.
