#!/usr/bin/env bash
# Symlink tracked Hypr + Illogical Impulse configs from this repo into ~/.config
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HYPR_TRACKED="$REPO_ROOT/hypr/.config/hypr"
II_JSON="$REPO_ROOT/illogical-impulse/.config/illogical-impulse/config.json"
DEST_HYPR="$HOME/.config/hypr"
DEST_II_DIR="$HOME/.config/illogical-impulse"

backup_if_plain_dir() {
  local path=$1
  if [[ -d "$path" && ! -L "$path" ]]; then
    local bak="${path}.bak.$(date +%Y%m%d%H%M%S)"
    echo "Backing up $path -> $bak"
    mv "$path" "$bak"
  fi
}

mkdir -p "$DEST_HYPR" "$DEST_II_DIR"

backup_if_plain_dir "$DEST_HYPR/custom"
backup_if_plain_dir "$DEST_HYPR/ricing"

ln -sfn "$HYPR_TRACKED/hyprland.conf" "$DEST_HYPR/hyprland.conf"
ln -sfn "$HYPR_TRACKED/custom" "$DEST_HYPR/custom"
ln -sfn "$HYPR_TRACKED/ricing" "$DEST_HYPR/ricing"

mkdir -p "$DEST_HYPR/hosts"
ln -sfn "$HYPR_TRACKED/hosts/desktop.conf" "$DEST_HYPR/hosts/desktop.conf"
ln -sfn "$HYPR_TRACKED/hosts/laptop.conf" "$DEST_HYPR/hosts/laptop.conf"

# Old nwg-displays files are unused once hyprland.conf sources hosts/local.conf only
for f in monitors.conf workspaces.conf; do
  if [[ -e "$DEST_HYPR/$f" && ! -L "$DEST_HYPR/$f" ]]; then
    mv "$DEST_HYPR/$f" "$DEST_HYPR/$f.bak.$(date +%Y%m%d%H%M%S)"
    echo "Archived obsolete $f (replaced by hosts/<profile>.conf)"
  fi
done

if [[ -f "$DEST_II_DIR/config.json" && ! -L "$DEST_II_DIR/config.json" ]]; then
  mv "$DEST_II_DIR/config.json" "$DEST_II_DIR/config.json.bak.$(date +%Y%m%d%H%M%S)"
  echo "Backed up existing illogical-impulse config.json"
fi
ln -sfn "$II_JSON" "$DEST_II_DIR/config.json"

echo "Symlinks installed from $REPO_ROOT"
echo "Run: $REPO_ROOT/scripts/set-host.sh desktop   # or: laptop"
echo "Then: hyprctl reload"
