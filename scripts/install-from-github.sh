#!/usr/bin/env bash
# Clone or update this repo, then run scripts/install.sh (safe for: curl ... | bash)
set -euo pipefail

: "${DOTFILES:=${HOME}/prj/dotfiles}"
: "${DOTFILES_GIT_URL:=https://github.com/MaxxWasHere/....git}"

if [[ -d "${DOTFILES}/.git" ]]; then
  echo "Updating ${DOTFILES}"
  git -C "${DOTFILES}" pull --ff-only
else
  mkdir -p "$(dirname "${DOTFILES}")"
  echo "Cloning into ${DOTFILES}"
  git clone -b main --depth 1 "${DOTFILES_GIT_URL}" "${DOTFILES}"
fi

bash "${DOTFILES}/scripts/install.sh"

if [[ -n "${DOTFILES_HOST:-}" ]]; then
  "${DOTFILES}/scripts/set-host.sh" "${DOTFILES_HOST}"
  command -v hyprctl >/dev/null 2>&1 && hyprctl reload || true
fi
