#!/usr/bin/env bash
# Point Hypr at hosts/desktop.conf or hosts/laptop.conf via hosts/local.conf symlink.
set -euo pipefail

PROFILE="${1:-}"
if [[ -z "$PROFILE" ]]; then
  echo "usage: $0 desktop|laptop" >&2
  exit 1
fi

if [[ "$PROFILE" != "desktop" && "$PROFILE" != "laptop" ]]; then
  echo "usage: $0 desktop|laptop (got: $PROFILE)" >&2
  exit 1
fi

HOSTS="$HOME/.config/hypr/hosts"
mkdir -p "$HOSTS"
ln -sfn "${PROFILE}.conf" "$HOSTS/local.conf"
echo "$HOSTS/local.conf -> ${PROFILE}.conf"
