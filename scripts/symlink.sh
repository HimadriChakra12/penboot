#!/usr/bin/env bash
set -e

DOTDIR="$HOME/penboot/dotfiles"

link() {
  src="$1"
  dest="$2"

  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
}

link "$DOTDIR/bashrc" "$HOME/.bashrc"
link "$DOTDIR/wezterm" "$HOME/.config/wezterm"
link "$DOTDIR/mpv" "$HOME/.config/mpv"
link "$DOTDIR/tmux.conf" "$HOME/.tmux.conf"
link "$DOTDIR/vimrc" "$HOME/.vimrc"
link "$DOTDIR/okular/okularrc" "$HOME/.config/okularrc"
link "$DOTDIR/okular/okularpartrc" "$HOME/.config/okularpartrc"
