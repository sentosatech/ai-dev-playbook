#!/usr/bin/env bash
set -euo pipefail

archive_url="${STC_AI_DEV_PLAYBOOK_ARCHIVE_URL:-https://github.com/sentosatech/ai-dev-playbook/archive/refs/heads/main.tar.gz}"
bootstrap_url="${STC_AI_DEV_PLAYBOOK_BOOTSTRAP_URL:-https://raw.githubusercontent.com/sentosatech/ai-dev-playbook/main/scripts/bootstrap-install.sh}"

usage() {
  cat <<'USAGE'
Usage: bootstrap-install.sh [--agents codex|claude|both]

Downloads AI Dev Playbook to a temporary directory and runs scripts/install-skills.sh.
By default, this installs new STC skills and refreshes existing STC-managed
skills without overwrite prompts.

Override these environment variables when testing a different source:
  STC_AI_DEV_PLAYBOOK_ARCHIVE_URL
  STC_AI_DEV_PLAYBOOK_BOOTSTRAP_URL
USAGE
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
esac

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/ai-dev-playbook.XXXXXX")"
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

archive="$tmp_dir/ai-dev-playbook.tar.gz"
extract_dir="$tmp_dir/extract"
mkdir -p "$extract_dir"

curl -fsSL "$archive_url" -o "$archive"
tar -xzf "$archive" -C "$extract_dir"

repo_dir="$(find "$extract_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "$repo_dir" || ! -x "$repo_dir/scripts/install-skills.sh" ]]; then
  echo "Downloaded archive does not contain scripts/install-skills.sh" >&2
  exit 1
fi

env \
  STC_SOURCE_PATH="" \
  STC_SOURCE_URL="$archive_url" \
  STC_BOOTSTRAP_URL="$bootstrap_url" \
  "$repo_dir/scripts/install-skills.sh" --refresh --yes "$@"
