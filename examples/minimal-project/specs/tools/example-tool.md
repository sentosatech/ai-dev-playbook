---
id: example-tool
status: approved
approved_by: example
approved_at: 2026-06-27
validated_by:
  - scripts/verify quick
---

# Example Tool

## Purpose

Demonstrate a tiny approved capability contract without choosing an
implementation language.

## Inputs

- `name`: short text label

## Outputs

- greeting text containing the provided name

## Behavior

The capability returns a deterministic greeting for the provided name.

## Verification

`scripts/verify quick` checks that this approved spec exists and includes the
expected contract fields.
