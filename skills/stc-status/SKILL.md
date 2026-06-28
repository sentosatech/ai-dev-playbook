---
name: stc-status
description: Report the current AI-development status of a repo by inspecting project docs, project state hints, git state, verification setup, and supporting artifacts. Use when the user asks where a repo stands, what has been done, what evidence supports it, what remains unclear or pending, and what the next human-AI session should be.
---

# STC Status

Report current repo status from local evidence. Be read-only by default.

## Inputs

- Target repo: the current working directory unless the user names another path.
- Primary evidence:
  - `PROJECT_CONTEXT.md`
  - `.ai/project-state.yaml`
  - `AGENTS.md`
  - `process.md`
  - git status and recent commits
- Supporting evidence when present:
  - `README.md`
  - `docs/architecture.md`
  - `docs/adr/`
  - `docs/change-log.md`
  - `specs/`
  - `scripts/verify`
  - issue or work-item docs
  - brainstorming docs such as `docs/initial-thinking.md`

## Workflow

1. Inspect the repo structure, git status, and recent commits.
2. Read the primary evidence files that exist.
3. Inspect supporting evidence paths that exist.
4. Treat `.ai/project-state.yaml` as a lightweight hint, not a workflow engine
   or source of truth. If it conflicts with repo evidence, report the conflict.
5. Separate:
   - approved or durable project truth
   - current project memory
   - actual repo state
   - pending or missing evidence
   - brainstorming or unpromoted notes
6. Mention ADRs only as architecture decision records:
   - ADR means Architecture Decision Record.
   - ADRs are useful when durable architecture decisions exist.
   - Do not imply ADRs are required if no architecture decision has been made.
7. Do not edit files unless the user explicitly asks for status updates to be
   written. If asked to edit, propose the exact update first.

## Reporting Style

Keep the report concise and evidence-led. Use this shape when useful:

```text
Current Status
What Has Been Done
Supporting Evidence
Pending Or Unclear
Verification
What AI Can Safely Do Next
What Needs Human Engineering Judgment
Suggested Next Human-AI Session
```

Use cautious language for missing artifacts:

- "not present"
- "not recorded yet"
- "pending if this decision becomes durable"
- "unpromoted source material"

Avoid rigid checkbox language such as:

- "required before progress"
- "blocked until every section is complete"
- "the repo is on step N"

## Verification

If `scripts/verify` exists, report the available command. Run it only if the
user asks for verification or if the status request explicitly includes a check.
If no verification path exists, say so clearly.
