# AI Dev Playbook

## Quick Start

Install the STC skills for Codex and/or Claude:

```bash
curl -fsSL https://raw.githubusercontent.com/sentosatech/ai-dev-playbook/main/scripts/bootstrap-install.sh | bash
```

Or inspect first:

```bash
curl -fsSL https://raw.githubusercontent.com/sentosatech/ai-dev-playbook/main/scripts/bootstrap-install.sh -o bootstrap-install.sh
less bootstrap-install.sh
bash bootstrap-install.sh
```

Or, from a local copy of this repo:

```bash
scripts/install-skills.sh
```

Or give this prompt to Codex or Claude:

```text
Install the STC AI Dev Playbook skills from
https://raw.githubusercontent.com/sentosatech/ai-dev-playbook/main/scripts/bootstrap-install.sh.
Use the bootstrap script so I do not have to clone or download the repo
manually. Install for the agent I am using, or ask whether to install for Codex,
Claude, or both. Do not use symlinks. If a same-name non-STC skill already
exists, stop and report it instead of overwriting. After install, tell me
whether I need to start a new agent session.
```

Start a new Codex or Claude session so the installed skills are visible.

In the repo you want to set up, run:

```text
Use $stc-setup-repo to set up this repo.
```

After pulling updates to this repo, refresh installed skills with:

```text
Use $stc-refresh-skills
```

or run:

```bash
scripts/install-skills.sh --refresh
```

Refresh updates installed STC-managed skills; it does not prune removed skills.
Run `scripts/install-skills.sh --help` for install options.

## What This Is

Small playbooks, templates, and skills for human-led, AI-assisted software
development.

STC is the shared prefix for this repo's agent skills.

## Contents

- `playbooks/`: repo structure, repo setup, project management, and agent process
- `templates/`: files copied into target repos
- `skills/`: Codex/Claude skills
- `examples/minimal-project/`: smallest working example
- `docs/history/`: historical source notes

## Principle

```text
Simplicity first. Monstrosity last.
```
