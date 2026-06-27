#!/usr/bin/env bash
set -euo pipefail

archive_url="${STC_AI_DEV_PLAYBOOK_ARCHIVE_URL:-__AI_DEV_PLAYBOOK_ARCHIVE_URL__}"
bootstrap_url="${STC_AI_DEV_PLAYBOOK_BOOTSTRAP_URL:-__AI_DEV_PLAYBOOK_BOOTSTRAP_URL__}"

usage() {
  cat <<'USAGE'
Usage: bootstrap-install.sh [--agents codex|claude|both] [--refresh] [--yes]

Downloads AI Dev Playbook to a temporary directory and runs scripts/install-skills.sh.

Set these environment variables until the public URLs are baked into the script:
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

if [[ "$archive_url" == "__AI_DEV_PLAYBOOK_ARCHIVE_URL__" ]]; then
  echo "Missing STC_AI_DEV_PLAYBOOK_ARCHIVE_URL." >&2
  echo "Set it to a .tar.gz archive URL for ai-dev-playbook." >&2
  exit 2
fi

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
  "$repo_dir/scripts/install-skills.sh" "$@"
