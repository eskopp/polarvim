#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
BACKUP_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim.bak.$(date +%Y%m%d-%H%M%S)"

echo "Repo:      $REPO_DIR"
echo "Target:    $NVIM_DIR"
echo "Backup:    $BACKUP_DIR"
echo

if [[ -e "$NVIM_DIR" && ! -L "$NVIM_DIR" ]]; then
  echo "Existing nvim config found (not a symlink). Backing it up..."
  mv "$NVIM_DIR" "$BACKUP_DIR"
elif [[ -L "$NVIM_DIR" ]]; then
  CURRENT_TARGET="$(readlink -f "$NVIM_DIR" || true)"
  if [[ "$CURRENT_TARGET" == "$REPO_DIR" ]]; then
    echo "Already installed: $NVIM_DIR -> $REPO_DIR"
    exit 0
  fi
  echo "Existing symlink found. Replacing it (current -> $CURRENT_TARGET)"
  rm -f "$NVIM_DIR"
fi

mkdir -p "$(dirname "$NVIM_DIR")"
ln -s "$REPO_DIR" "$NVIM_DIR"

echo
echo "Installed symlink:"
ls -la "$NVIM_DIR"
echo
echo "Done."
