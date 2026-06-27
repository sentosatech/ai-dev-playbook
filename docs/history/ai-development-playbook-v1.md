# AI Development Playbook v1 Source Notes

Status: historical source notes

This document records the reasoning and agreed v1 shape for the AI Development
Playbook. It is intentionally kept as historical context. The live source of
truth should become the implemented files in the repository root, templates, and
examples.

## For Humans

### Purpose

The AI Development Playbook is reusable, organization-level guidance for
human-led, AI-assisted software development.

The scope is broader than code. It includes repo structure, project state,
architecture decisions, approval gates, implementation workflow, verification,
and durable agent guidance.

The current priority is not to normalize Python, TypeScript, service, or app
source layouts. The priority is to normalize the human-readable structures,
agent instructions, process checkpoints, decision records, and verification
interface that help humans and coding agents develop software predictably.

Principle:

```text
Simplicity first. Monstrosity last.
```

### Agreed v1 Repo Shape

```text
ai-development-playbook/
  README.md
  repo.md
  project-management.md
  agent-process.md
  applying-the-playbook.md

  templates/
    AGENTS.md
    PROJECT_CONTEXT.md
    process.md
    project-state.yaml
    adr.md
    tool-spec.md
    issue.md
    verify.example

  examples/
    minimal-project/

  docs/
    history/
      ai-development-playbook-v1.md
```

### Core Model

```text
central playbook repo
  owns reusable guidance, process docs, templates, examples, and conventions

project repo
  owns local product truth, architecture, specs, ADRs, code, tests, state, and
  verification implementation

human engineer
  owns architecture, tradeoffs, boundaries, interfaces, approval, and judgment

coding agent
  follows process, drafts options, records decisions, implements approved work,
  runs verification, and keeps context current
```

This gives us a portable operating model without forcing every repo through the
same implementation skeleton.

### Why This Is Small

Earlier thinking included useful ideas but too much early machinery:

- blueprint manifests
- upgrade scripts
- overlay systems
- internal schemas
- many process files
- parallel skill trees
- future repo-upgrade flows

The v1 decision is:

```text
Start with short Markdown guidance, copyable templates, one minimal example, and
one normalized verification interface.
Add mechanical automation only after manual repetition proves the shape.
```

If and when deterministic project generation or update mechanics are needed, use
a real tool such as Copier rather than asking an LLM to hand-merge managed files
from a custom manifest. Agents are better at judgment than safe file-update
mechanics.

### Live Guidance Files

Each artifact has exactly one owning guidance doc. Other docs may reference or
link to it, but should not redefine it.

#### `repo.md`

Purpose: define recommended repo artifacts and their roles.

Owns:

- what files/folders an AI-ready repo should usually contain
- source-of-truth hierarchy
- `AGENTS.md` as canonical agent instructions
- `PROJECT_CONTEXT.md` as current project truth
- `process.md` as the local workflow
- `docs/architecture.md`, `docs/adr/`, `docs/change-log.md`
- `specs/` for capability contracts, schemas, RPC/REST/SDK/CLI specs
- optional `scripts/verify` as the standard verification interface
- optional growth folders such as `deliverables/`

#### `project-management.md`

Purpose: define how work is tracked without adding a heavy PM system.

Owns:

- `PROJECT_CONTEXT.md` conventions
- lightweight status tables
- durable approval records
- issue/work-item conventions
- changelog expectations
- optional `deliverables/` conventions
- what goes in `.ai/project-state.yaml`
- where the project's verification command/profile is documented
- fast path versus full path

#### `agent-process.md`

Purpose: define the repeatable human-plus-agent workflow.

Owns the five-move spine:

```text
Frame
  -> Contract + approve
  -> Architecture + approve
  -> Slice + approve
  -> Build + Verify + Close
```

#### `applying-the-playbook.md`

Purpose: define how a human or agent applies the playbook to a new or existing
repo without introducing a scaffolding tool yet.

Expected guidance:

- new repo: copy templates, fill `PROJECT_CONTEXT.md`, create `AGENTS.md` and
  `process.md`, wire `scripts/verify quick`, initialize `.ai/project-state.yaml`
- existing repo: add only missing docs, never overwrite local truth, wire
  `scripts/verify` to existing checks where practical

### Verification

Verification is a required project concept, not a required implementation
technology.

Every project should document how agents verify work before closeout. The
recommended standard interface is:

```text
scripts/verify [profile]
```

Recommended profiles:

```text
quick
  Fast default confidence check for normal changes. Usually unit tests, lint,
  type checks, schema checks, or a focused subset.

smoke
  Basic operational sanity check. Usually proves the app, CLI, API, workflow, or
  generated artifact can run end-to-end in a minimal way.

full
  Broader confidence suite for risky changes, public contracts, releases, or
  architecture-sensitive work.
```

Manual verification is fallback behavior, not a profile. If automated
verification is unavailable, the agent should report that clearly and follow
documented manual review steps.

The profile names are normalized so agents have a predictable vocabulary. The
implementation remains repo-specific.

This is not a replacement for conventional testing. It is a stable agent-facing
entry point for conventional testing, linting, typechecking, smoke testing,
schema validation, artifact inspection, or manual review.

### Verification Script Skeleton

`templates/verify.example` may provide a copyable skeleton:

```bash
#!/usr/bin/env bash
set -euo pipefail

profile="${1:-quick}"

case "$profile" in
  quick)
    echo "No quick verification configured for this repo." >&2
    exit 1
    ;;
  smoke)
    echo "No smoke verification configured for this repo." >&2
    exit 1
    ;;
  full)
    echo "No full verification configured for this repo." >&2
    exit 1
    ;;
  *)
    echo "Unknown verification profile: $profile" >&2
    echo "Usage: scripts/verify [quick|smoke|full]" >&2
    exit 2
    ;;
esac
```

The skeleton normalizes the interface without pretending the playbook knows the
repo's implementation details. It should fail clearly for unconfigured automated
profiles so agents do not mistake a placeholder for real verification.

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

### Project State

The playbook can include a template for:

```text
.ai/project-state.yaml
```

Purpose:

- record current process move
- record pending approval gates
- point to approval artifacts
- support resume across sessions
- avoid relying on chat history as project memory

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

This is a checkpoint, not a database. It should stay loose until tooling needs a
schema.

### Durable Approval Metadata

Approval front matter should live inside relevant templates such as
`tool-spec.md`:

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

Purpose:

- make approval durable
- let agents know whether work may proceed
- connect specs to tests
- avoid treating chat history as the only record

### Specs

Project repos may use `specs/` for more than tool specs.

Examples:

```text
specs/
  tools/       # agent-callable capability contracts
  schemas/     # authoritative data shapes
  rpc/         # JSON-RPC contracts
  rest/        # REST endpoint contracts
  sdk/         # client/library surface contracts
  cli/         # command-line contracts
  storage/     # file/database/object layout contracts
```

Create only the specs a project actually needs.

### Optional Growth Later

Add only when there is repeated pain.

```text
blueprints/
  Copier templates, when repeated setup justifies automation.

skills/
  Thin tool-specific wrappers, after process docs prove stable.

scripts/
  Playbook-level helpers, when manual use repeats.

schemas/
  Validation for playbook internals, when tools consume them.
```

### What We Are Deliberately Not Doing Yet

- No implementation-specific source-code blueprints.
- No mandatory Python/TypeScript/service layout.
- No company/customer overlay system.
- No generated repo-upgrade workflow.
- No parallel Codex and Claude skill trees.
- No custom agentic pipeline.
- No Backstage-style platform.
- No schema system for the playbook itself.

## For LLMs

### Operating Rule

When applying this playbook, keep the system small unless the user explicitly
asks to grow it.

Default to:

```text
README + four guidance docs + templates + one minimal example
```

Do not create `blueprints/`, `skills/`, playbook-level `scripts/`, or `schemas/`
unless there is a concrete reason.

### Source-Of-Truth Boundaries

```text
repo.md
  Defines recommended repo artifacts, source-of-truth hierarchy, and the
  `scripts/verify` interface.

project-management.md
  Defines how project state, approvals, issues, deliverables, history, and
  verification configuration are tracked.

agent-process.md
  Defines the human-plus-agent workflow, verification triggers, and definition
  of done.

applying-the-playbook.md
  Defines new-repo and existing-repo application procedures.

templates/
  Provides copyable starting points.

examples/minimal-project/
  Shows the guidance applied in the smallest understandable way.
```

Each artifact has exactly one owning guidance doc. Cross-link instead of
re-describing.

### Agent Behavior

Agents should:

- preserve human control of architecture and public contracts
- stop for approval at contract, architecture, and implementation-slice gates
- record approvals in durable artifacts
- update project state when work progresses
- run the documented verification profile before closeout
- report clearly when verification cannot be run
- prefer existing repo conventions over generic advice
- avoid adding process files that nobody will maintain

Agents should not:

- treat chat approval as the only durable approval record
- create complex automation before repeated manual use proves it useful
- invent scaffolding/update mechanisms when a mature tool can do the job
- duplicate the same instructions across multiple files without a clear owner
- turn the playbook into a universal source-code architecture

### Verification Rules For Agents

Before closeout:

1. Look for the repo's documented verification instructions in `AGENTS.md`,
   `PROJECT_CONTEXT.md`, or `process.md`.
2. If `scripts/verify` exists, run the appropriate profile:
   - `quick` for normal changes
   - `smoke` when runtime or workflow sanity matters
   - `full` for risky, public-contract, release, or architecture-sensitive work
3. If no verification path exists, say that clearly in the final response.
4. Never claim verification passed unless it was actually run.

### Suggested Creation Order

For the live playbook repo:

1. Write `README.md`.
2. Write `repo.md`.
3. Write `project-management.md`.
4. Write `agent-process.md`.
5. Write `applying-the-playbook.md`.
6. Add `templates/`.
7. Add `examples/minimal-project/`.
8. Stop.

After that, only add growth folders when real use demonstrates the need.
