---
name: stc-setup-repo
description: Apply the STC AI Dev Playbook to a new or existing repo by adding missing agent guidance, project context, process docs, project state, and verification scaffolding without overwriting local truth. Use when bootstrapping or adopting AI-assisted development structure in a repository.
---

# STC Setup Repo

Apply the STC AI Dev Playbook to the current target repository.

## Inputs

- Target repo: the current working directory unless the user names another path.
- Templates: use `assets/templates/` bundled with this skill.
- References:
  - `references/repo-setup.md`
  - `references/repo-structure.md`
  - `references/project-management.md`

## Workflow

1. Inspect the target repo before editing.
2. Read the references needed for the repo type:
   - always read `repo-setup.md`
   - read `repo-structure.md` when deciding which artifacts belong in the repo
   - read `project-management.md` when adding project state, approval, issue,
     changelog, or verification-tracking structure
3. Identify existing equivalents for:
   - agent instructions
   - project context
   - process or workflow docs
   - architecture docs and ADRs
   - specs or contracts
   - project state
   - verification commands
4. Show a short proposed setup plan before editing:
   - files to add
   - existing files to leave unchanged
   - optional files or decisions that need the user's input
   - verification command to run, if known
5. Ask for confirmation before making changes unless the user already explicitly
   approved the exact plan.
6. Add only missing scaffolding that provides immediate value.
7. Never overwrite local project truth. If a target file exists, inspect it and
   adapt around it instead of replacing it.
8. Prefer existing repo conventions over playbook defaults.
9. Wire `scripts/verify` to existing checks only when the command is obvious.
   If it is not obvious, install the fail-loud placeholder only when the user
   asks for the standard interface.
10. Report what was added, skipped, and left for human decision.

## Default Artifacts

For a repo with no existing equivalents, the usual minimum is:

```text
AGENTS.md
PROJECT_CONTEXT.md
process.md
.ai/project-state.yaml
```

Add these only when useful:

```text
docs/architecture.md
docs/change-log.md
docs/adr/
templates/
scripts/verify
```

Do not create empty folders just to satisfy a template shape.

## Verification

After edits:

1. Run the target repo's documented verification if it exists.
2. If `scripts/verify` exists, run `scripts/verify quick` unless a different
   profile is clearly appropriate.
3. If no verification path exists, say so clearly.
4. Never claim verification passed unless it was actually run.
