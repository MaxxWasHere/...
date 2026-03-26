#!/usr/bin/env bash
# Run on the laptop after cloning this repo (set REPO_CLONE_URL first or pass as $1).
set -euo pipefail

REPO_URL="${1:-}"
REPO_PATH="${2:-$HOME/prj/dotfiles}"

if [[ -z "$REPO_URL" ]]; then
  echo "usage: $0 <git-clone-url> [clone-directory]"
  echo "example: $0 git@github.com:you/dotfiles.git $HOME/prj/dotfiles"
  exit 1
fi

STAMP="$(date +%Y%m%d%H%M%S)"
BACK="$HOME/.config/dotfiles-backup-$STAMP"
mkdir -p "$BACK"
[[ -d "$HOME/.config/hypr" ]] && cp -a "$HOME/.config/hypr" "$BACK/hypr"
[[ -f "$HOME/.config/illogical-impulse/config.json" ]] && cp -a "$HOME/.config/illogical-impulse/config.json" "$BACK/config.json"

echo "Backup at $BACK"

if [[ ! -d "$REPO_PATH/.git" ]]; then
  git clone "$REPO_URL" "$REPO_PATH"
else
  echo "Repo already exists at $REPO_PATH — pulling latest"
  git -C "$REPO_PATH" pull --ff-only || true
fi

"$REPO_PATH/scripts/install.sh"
"$REPO_PATH/scripts/set-host.sh" laptop

echo "Edit $REPO_PATH/hypr/.config/hypr/hosts/laptop.conf for your panels, commit if you like, then:"
echo "  hyprctl reload"
echo "Align Illogical Impulse / end-4 versions with your other machine before expecting identical behavior."
