#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_dir="$repo_root/skills"
templates_dir="$repo_root/templates"
marker_source_path="${STC_SOURCE_PATH-$repo_root}"
marker_source_url="${STC_SOURCE_URL:-}"
marker_bootstrap_url="${STC_BOOTSTRAP_URL:-}"

agents=""
refresh=false
yes_all=false

usage() {
  cat <<'USAGE'
Usage: scripts/install-skills.sh [--agents codex|claude|both] [--refresh] [--yes]

Installs STC AI Dev Playbook skills globally for Codex and/or Claude.

Options:
  --agents VALUE   Target agent: codex, claude, or both
  --refresh        Refresh existing STC-managed skills without overwrite prompts
  --yes            Answer yes to STC-managed overwrite prompts
  -h, --help       Show this help
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --agents)
      if [[ $# -lt 2 ]]; then
        echo "Missing value for --agents" >&2
        exit 2
      fi
      agents="$2"
      shift 2
      ;;
    --refresh)
      refresh=true
      shift
      ;;
    --yes|-y)
      yes_all=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ! -d "$skills_dir" ]]; then
  echo "Missing skills directory: $skills_dir" >&2
  exit 1
fi

if [[ ! -d "$templates_dir" ]]; then
  echo "Missing templates directory: $templates_dir" >&2
  exit 1
fi

prompt_agents() {
  local codex_exists=false
  local claude_exists=false
  [[ -d "$HOME/.codex" ]] && codex_exists=true
  [[ -d "$HOME/.claude" ]] && claude_exists=true

  local default="both"
  if [[ "$codex_exists" == true && "$claude_exists" != true ]]; then
    default="codex"
  elif [[ "$codex_exists" != true && "$claude_exists" == true ]]; then
    default="claude"
  fi

  echo "Install STC skills for:"
  echo "  1) Codex  (~/.codex/skills)"
  echo "  2) Claude (~/.claude/skills)"
  echo "  3) Both"
  printf "Choice [default: %s]: " "$default" >&2

  local choice
  read -r choice
  case "${choice:-$default}" in
    1|codex|Codex|CODEX) agents="codex" ;;
    2|claude|Claude|CLAUDE) agents="claude" ;;
    3|both|Both|BOTH) agents="both" ;;
    *)
      echo "Invalid agent choice: $choice" >&2
      exit 2
      ;;
  esac
}

if [[ -z "$agents" ]]; then
  prompt_agents
fi

case "$agents" in
  codex|claude|both) ;;
  *)
    echo "Invalid --agents value: $agents" >&2
    echo "Expected: codex, claude, or both" >&2
    exit 2
    ;;
esac

targets=()
case "$agents" in
  codex)
    targets+=("$HOME/.codex/skills")
    ;;
  claude)
    targets+=("$HOME/.claude/skills")
    ;;
  both)
    targets+=("$HOME/.codex/skills" "$HOME/.claude/skills")
    ;;
esac

confirm_overwrite() {
  local dest="$1"
  if [[ "$yes_all" == true || "$refresh" == true ]]; then
    return 0
  fi

  printf "Existing STC skill found: %s\nOverwrite/refresh it? [y/N/all] " "$dest" >&2
  local answer
  read -r answer
  case "$answer" in
    y|Y|yes|YES|Yes)
      return 0
      ;;
    all|ALL|All)
      yes_all=true
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

copy_dir_contents() {
  local src="$1"
  local dest="$2"
  mkdir -p "$dest"
  cp -R "$src"/. "$dest"/
}

bundle_generated_assets() {
  local skill_name="$1"
  local dest="$2"

  case "$skill_name" in
    stc-setup-repo)
      rm -rf "$dest/assets/templates"
      mkdir -p "$dest/assets/templates"
      copy_dir_contents "$templates_dir" "$dest/assets/templates"
      ;;
  esac
}

refresh_references() {
  local skill_name="$1"
  local dest="$2"

  case "$skill_name" in
    stc-setup-repo)
      mkdir -p "$dest/references"
      cp "$repo_root/playbooks/repo-setup.md" "$dest/references/repo-setup.md"
      cp "$repo_root/playbooks/repo-structure.md" "$dest/references/repo-structure.md"
      cp "$repo_root/playbooks/project-management.md" "$dest/references/project-management.md"
      ;;
  esac
}

write_marker() {
  local dest="$1"
  {
    echo "source=stc/ai-dev-playbook"
    echo "managed=true"
    if [[ -n "$marker_source_path" ]]; then
      echo "source_path=$marker_source_path"
    fi
    if [[ -n "$marker_source_url" ]]; then
      echo "source_url=$marker_source_url"
    fi
    if [[ -n "$marker_bootstrap_url" ]]; then
      echo "bootstrap_url=$marker_bootstrap_url"
    fi
  } > "$dest/.stc-skill"
}

install_skill() {
  local skill_src="$1"
  local target_root="$2"
  local skill_name
  skill_name="$(basename "$skill_src")"

  local dest="$target_root/$skill_name"

  if [[ -e "$dest" ]]; then
    if [[ ! -f "$dest/.stc-skill" ]]; then
      echo "Refusing to overwrite non-STC skill: $dest" >&2
      return 1
    fi

    if ! confirm_overwrite "$dest"; then
      echo "Skipped: $dest"
      return 0
    fi

    rm -rf "$dest"
  fi

  mkdir -p "$target_root"
  mkdir -p "$dest"
  copy_dir_contents "$skill_src" "$dest"
  refresh_references "$skill_name" "$dest"
  bundle_generated_assets "$skill_name" "$dest"
  write_marker "$dest"

  echo "Installed: $dest"
}

installed_any=false
failed=false

shopt -s nullglob
skill_sources=("$skills_dir"/stc-*)
shopt -u nullglob

if [[ ${#skill_sources[@]} -eq 0 ]]; then
  echo "No STC skills found in $skills_dir" >&2
  exit 1
fi

for target_root in "${targets[@]}"; do
  mkdir -p "$target_root"
  for skill_src in "${skill_sources[@]}"; do
    if [[ ! -f "$skill_src/SKILL.md" ]]; then
      continue
    fi

    if install_skill "$skill_src" "$target_root"; then
      installed_any=true
    else
      failed=true
    fi
  done
done

echo
if [[ "$failed" == true ]]; then
  if [[ "$refresh" == true ]]; then
    echo "Refresh completed with errors."
  else
    echo "Install completed with errors."
  fi
elif [[ "$refresh" == true ]]; then
  echo "Refresh complete."
else
  echo "Install complete."
fi
echo "Start a new Codex or Claude session if updated skills are not visible."

if [[ "$installed_any" != true || "$failed" == true ]]; then
  exit 1
fi
