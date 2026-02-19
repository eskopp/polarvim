#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

echo "Target: $NVIM_DIR"
echo

if [[ ! -e "$NVIM_DIR" ]]; then
  echo "Nothing to uninstall (no $NVIM_DIR)."
  exit 0
fi

if [[ -L "$NVIM_DIR" ]]; then
  CURRENT_TARGET="$(readlink -f "$NVIM_DIR" || true)"
  if [[ "$CURRENT_TARGET" == "$REPO_DIR" ]]; then
    echo "Removing symlink $NVIM_DIR -> $CURRENT_TARGET"
    rm -f "$NVIM_DIR"
    echo "Uninstalled."
    exit 0
  fi
  echo "Refusing: $NVIM_DIR is a symlink, but not to this repo:"
  echo "  -> $CURRENT_TARGET"
  echo "If you really want to remove it, delete it manually:"
  echo "  rm -f \"$NVIM_DIR\""
  exit 1
fi

echo "Refusing: $NVIM_DIR exists and is not a symlink."
echo "I won't delete real directories automatically."
echo "Move it away manually if you want:"
echo "  mv \"$NVIM_DIR\" \"${NVIM_DIR}.bak\""
exit 1
