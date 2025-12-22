#!/usr/bin/env bash
set -e

DOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/dotfiles"

link() {
  src="$1"
  dest="$2"

  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
}

link "$DOTDIR/.bashrc" "$HOME/.bashrc"
link "$DOTDIR/wezterm" "$HOME/wezterm"
link "$DOTDIR/.tmux.conf" "$HOME/.tmux.conf"

