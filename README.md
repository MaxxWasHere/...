# Dotfiles (Hypr + Illogical Impulse)

Tracked: `hypr/custom`, `hypr/ricing`, `hypr/hyprland.conf`, `hypr/hosts`, `illogical-impulse/config.json`. Upstream `hypr/hyprland/*.conf` stays from your end-4 / II install.

## Install (one command)

```bash
curl -fsSL 'https://raw.githubusercontent.com/MaxxWasHere/.../main/scripts/install-from-github.sh' | bash
```

Optional: set clone dir, repo URL, and host profile in one go:

```bash
DOTFILES_HOST=desktop curl -fsSL 'https://raw.githubusercontent.com/MaxxWasHere/.../main/scripts/install-from-github.sh' | bash
```

| Variable | Default | Meaning |
|----------|---------|---------|
| `DOTFILES` | `$HOME/prj/dotfiles` | Where the repo is cloned |
| `DOTFILES_GIT_URL` | `https://github.com/MaxxWasHere/....git` | Clone URL (HTTPS; public clone needs no token) |
| `DOTFILES_HOST` | *(empty)* | If set to `desktop` or `laptop`, runs `set-host.sh` and `hyprctl reload` when available |

If you skip `DOTFILES_HOST`, run after install:

```bash
~/prj/dotfiles/scripts/set-host.sh desktop   # or laptop
hyprctl reload
```

## Push changes (needs auth)

Use SSH (`git@github.com:MaxxWasHere/....git`) or HTTPS with a [personal access token](https://github.com/settings/tokens). GitHub does not accept account passwords for Git.
