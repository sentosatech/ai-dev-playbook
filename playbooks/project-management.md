# Project Management Guidance

This document defines lightweight project tracking for AI-assisted development.
The goal is enough state for humans and agents to know what is true, what is
pending, what was approved, and what changed.

This is not a replacement for issue trackers or planning tools. It is the local
project memory agents can reliably read.

## Ownership

This file owns:

- `PROJECT_CONTEXT.md` conventions
- `.ai/project-state.yaml`
- durable approval records
- issue/work-item conventions
- changelog expectations
- optional deliverables conventions
- verification configuration location

Repo artifact roles are owned by [repo-structure.md](repo-structure.md). Workflow is owned by
[agent-process.md](agent-process.md).

## `PROJECT_CONTEXT.md`

`PROJECT_CONTEXT.md` is current project truth. Keep it concise and current.

Recommended sections:

```markdown
# Project Context

## Status

## Current Priorities

## Architecture Decisions

## Verification

## Open Questions

## Recent Changes
```

Use tables when they make scanning easier, but avoid turning the file into a
large project-management database.

## Verification Configuration

Each project should document its verification path in `PROJECT_CONTEXT.md` or
`AGENTS.md`.

Recommended form:

```markdown
## Verification

Default profile: quick

Command:

```bash
scripts/verify quick
```

Profiles:

- quick: fast confidence check for normal changes
- smoke: basic operational sanity check
- full: broader confidence suite for risky changes

Manual fallback: describe any required human inspection here.
```

## Project State

`.ai/project-state.yaml` is a checkpoint for active work. It is not a database.

Use it to track:

- current process
- current move
- pending approval gates
- approval artifacts
- verification command/default profile
- last update

Example:

```yaml
current_process:
  name: idea-to-spec
  current_move: contract
  status: in_progress

pending_approvals:
  - contract

approval_artifacts:
  contract: specs/tools/example.md

verification:
  default_profile: quick
  command: scripts/verify

last_updated: 2026-06-27
```

Keep this loose until tooling needs a schema.

## Approval Records

Human approval must be recorded in durable artifacts. Chat-only approval is not
enough for work that may continue across sessions.

Appropriate places:

- spec front matter
- ADR status
- issue checklist
- `.ai/project-state.yaml`

Example front matter:

```yaml
---
id: capability-name
status: draft
approved_by:
approved_at:
validated_by:
  - tests/path/to/test_file.py
---
```

## Issues And Work Items

Keep implementation slices small enough that an agent can finish, verify, and
report clearly.

Recommended issue shape:

```markdown
# Title

## Goal

## Approved Inputs

## Implementation Notes

## Verification

## Done When
```

Issues should reference approved specs or ADRs when they depend on contract or
architecture decisions.

## Changelog

Use `docs/change-log.md` for durable history that future humans and agents should
see.

Record:

- user-facing behavior changes
- contract changes
- architecture decisions becoming active
- verification changes
- notable migration/setup changes

Do not record every tiny edit.

## Deliverables

`deliverables/` is optional. Use it for non-code outputs such as decks,
one-pagers, customer briefs, funding notes, explainers, and demo runbooks.

Recommended conventions:

- write a short design/rationale doc before producing a polished artifact
- use explicit version names such as `_v1`, `_v2`, and `_final`
- do not overwrite drafts silently
