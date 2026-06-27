# Repo Guidance

This document defines the recommended artifacts and source-of-truth hierarchy
for an AI-ready project repo.

## Ownership Rule

Each artifact has exactly one owning guidance doc. Other docs may reference or
link to it, but should not redefine it.

This file owns repo structure and artifact roles. Project state is owned by
[project-management.md](project-management.md). Workflow is owned by
[agent-process.md](agent-process.md).

## Recommended Project Shape

Use only what the project needs.

```text
project/
  README.md
  AGENTS.md
  PROJECT_CONTEXT.md
  process.md

  docs/
    architecture.md
    change-log.md
    adr/

  specs/
    tools/
    schemas/
    rpc/
    rest/
    sdk/
    cli/
    storage/

  templates/
    adr.md
    tool-spec.md
    issue.md

  .ai/
    project-state.yaml

  scripts/
    verify
```

Do not create empty folders just to satisfy this list. Start with the smallest
set that makes the project understandable and maintainable.

## Source Of Truth

```text
README.md
  Human overview and first entry point.

AGENTS.md
  Canonical coding-agent instructions for the repo.

PROJECT_CONTEXT.md
  Current project state, priorities, verification configuration, recent changes,
  and open work.

process.md
  Local copy of the five-move human-plus-agent workflow.

docs/architecture.md
  Current architecture and major design boundaries.

docs/adr/
  Durable decision history.

docs/change-log.md
  Durable project history worth preserving across sessions.

specs/
  Public or cross-component contracts: tools, schemas, RPC, REST, SDK, CLI, or
  storage layouts.

.ai/project-state.yaml
  Lightweight checkpoint for current process state and pending approvals.

scripts/verify
  Optional standard verification interface for agents.
```

## Agent Instructions

Use `AGENTS.md` as the canonical repository instruction file for coding agents.
If a tool also wants a tool-specific file, make it point back to `AGENTS.md`
instead of duplicating rules.

Example `CLAUDE.md`:

```markdown
# Claude Code Instructions

Follow `AGENTS.md`. It is the canonical agent instruction file for this repo.
```

## Specs

`specs/` is for important external or cross-component contracts.

Common options:

```text
specs/tools/       # agent-callable capability contracts
specs/schemas/     # authoritative data shapes
specs/rpc/         # JSON-RPC contracts
specs/rest/        # REST endpoint contracts
specs/sdk/         # client/library surface contracts
specs/cli/         # command-line contracts
specs/storage/     # file/database/object layout contracts
```

Create only the specs a project actually needs.

## Verification Interface

Verification is a required project concept, not a required implementation
technology.

Recommended interface:

```text
scripts/verify [profile]
```

Recommended profiles:

```text
quick
  Fast default confidence check for normal changes.

smoke
  Basic operational sanity check. Proves a CLI, API, app, workflow, or generated
  artifact can run in a minimal way.

full
  Broader confidence suite for risky changes, public contracts, releases, or
  architecture-sensitive work.
```

Manual verification is fallback behavior, not a profile. If automated
verification is unavailable, agents should report that clearly and follow
documented manual review steps.

The implementation of `scripts/verify` is repo-specific. It may call `pytest`,
`npm test`, `make`, `just`, `go test`, `cargo test`, schema validators, smoke
scripts, or manual checks.

## Optional Growth

Add only when repeated use proves the need:

```text
blueprints/    # Copier templates or similar deterministic scaffolding
skills/        # thin tool-specific wrappers around stable process docs
schemas/       # validation for playbook metadata when tooling consumes it
deliverables/  # decks, briefings, one-pagers, demo runbooks, or other outputs
```
