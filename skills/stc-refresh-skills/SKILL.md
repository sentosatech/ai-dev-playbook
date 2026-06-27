---
name: stc-refresh-skills
description: Refresh installed STC AI Dev Playbook skills for Codex and Claude by running the canonical ai-dev-playbook install script in refresh mode. Use when the playbook repo has changed or installed STC skills are stale.
---

# STC Refresh Skills

Refresh installed STC skills by running the canonical installer. Do not
reimplement copy, marker, overwrite, or template-bundling logic in this skill.

## Workflow

1. Locate the `ai-dev-playbook` source.
   - First, inspect this installed skill's `.stc-skill` marker for
     `source_path=...` or `bootstrap_url=...`.
   - Prefer `source_path` when it exists and contains
     `scripts/install-skills.sh`.
   - Use `bootstrap_url` when there is no valid local source path.
   - If neither is usable, ask the user for the local `ai-dev-playbook` path or
     bootstrap URL.
2. Confirm the refresh command is available:
   - local source: `scripts/install-skills.sh`
   - remote bootstrap: `curl -fsSL "$bootstrap_url" | bash -s -- ...`
3. Decide the agent target:
   - use the user's explicit target if provided
   - use `both` when both `~/.codex/skills` and `~/.claude/skills` exist
   - use `codex` when only `~/.codex/skills` exists
   - use `claude` when only `~/.claude/skills` exists
   - ask the user if the target is still unclear
4. Run one of these:

   ```bash
   scripts/install-skills.sh --refresh --yes --agents <codex|claude|both>
   ```

   ```bash
   curl -fsSL "$bootstrap_url" | bash -s -- --refresh --yes --agents <codex|claude|both>
   ```
5. Report the refreshed paths and remind the user to start a new agent session
   if the current session does not see updated skills.

## Boundaries

- Do not edit installed skill files directly.
- Do not overwrite non-STC skill folders manually.
- Do not create symlinks.
- Do not update repo-local skills.
- Refresh updates and overwrites STC-managed skill folders, but it does not
  prune removed skills.
