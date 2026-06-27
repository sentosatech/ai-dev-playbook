# Applying The Playbook

This document defines how to apply the playbook to a new or existing repo
without introducing scaffolding tooling yet.

Use prose and copyable templates first. Add Copier, skills, or automation only
after repeated manual application proves a real need.

## New Repo

1. Create or enter the new repo.
2. Copy relevant files from `templates/`.
3. Fill `README.md` with the project overview.
4. Create `AGENTS.md` from `templates/AGENTS.md`.
5. Create `PROJECT_CONTEXT.md` from `templates/PROJECT_CONTEXT.md`.
6. Create `process.md` from `templates/process.md`.
7. Create `.ai/project-state.yaml` from `templates/project-state.yaml`.
8. Add `docs/architecture.md`, `docs/change-log.md`, and `docs/adr/` if the
   project has durable architecture or history to track.
9. Add `specs/` only for contracts the project actually needs.
10. Add `scripts/verify` from `templates/verify.example` only when there is a
    real verification path to wire, or when the repo wants the standard
    fail-loud placeholder.
11. Document the verification command/profile in `PROJECT_CONTEXT.md`.
12. Run the documented verification profile if configured.

Do not create empty folders or placeholder docs that nobody will maintain.

## Existing Repo

1. Inspect the current repo structure and conventions.
2. Identify existing equivalents for agent instructions, project context,
   process, specs, architecture docs, tests, and verification.
3. Add only missing files that provide immediate value.
4. Never overwrite local project truth.
5. Prefer adapting existing docs over adding duplicate docs.
6. Add `AGENTS.md` if the repo lacks canonical agent instructions.
7. Add `PROJECT_CONTEXT.md` if the repo lacks current state that agents can
   reliably read.
8. Add `process.md` if the repo lacks explicit human-plus-agent workflow.
9. Wire `scripts/verify` to existing tests/checks if practical.
10. If no automated verification exists, document manual fallback clearly.
11. Record adoption notes in `PROJECT_CONTEXT.md` or `docs/change-log.md`.

Existing repos are allowed to keep their own conventions. The playbook should
clarify and stabilize the repo, not bulldoze it.

## Runtime Truth

The playbook's guidance files are consumed when applying or updating project
practice. Once applied, the project repo's own files are runtime truth:

```text
AGENTS.md
PROJECT_CONTEXT.md
process.md
docs/
specs/
.ai/project-state.yaml
scripts/verify
```

Agents working inside a project should follow the local project files first.
Return to the playbook only when setting up, improving, or repairing the local
project structure.
