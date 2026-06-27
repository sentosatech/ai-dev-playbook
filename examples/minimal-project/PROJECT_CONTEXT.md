# Project Context

## Status

This is a minimal example project used to demonstrate the playbook structure.

## Current Priorities

| Priority | Status | Notes |
| --- | --- | --- |
| Demonstrate spec -> verification loop | Done | See `specs/tools/example-tool.md` and `scripts/verify`. |

## Architecture Decisions

| Decision | Status | Reference |
| --- | --- | --- |
| Use language-neutral shell verification | Accepted | `docs/architecture.md` |

## Verification

Default profile: quick

Command:

```bash
scripts/verify quick
```

Profiles:

- quick: validates the example spec and project context exist and contain expected markers
- smoke: delegates to quick
- full: delegates to quick and checks core playbook files

Manual fallback: inspect the files listed above if the shell script cannot run.

## Open Questions

| Question | Owner | Status |
| --- | --- | --- |
| None |  | Closed |

## Recent Changes

| Date | Change | Reference |
| --- | --- | --- |
| 2026-06-27 | Created minimal language-neutral example. | `scripts/verify` |
