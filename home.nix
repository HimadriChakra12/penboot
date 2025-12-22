{ config, pkgs, ... }:

{
  # User and home directory configuration
  home.username = "him";
  home.homeDirectory = "/home/him";

  # Dotfile configurations
  home.file.".bashrc".source = ./dotfiles/.bashrc;
  home.file.".tmux.conf".source = ./dotfiles/.tmux.conf;
  home.file.".config/i3".source = ./dotfiles/i3;
  home.file.".config/dunst".source = ./dotfiles/dunst;
  home.file.".config/rofi".source = ./dotfiles/rofi;
  home.file.".config/wezterm".source = ./dotfiles/wezterm;

  # Add more packages and programs
  home.packages = [
    pkgs.git
    pkgs.tmux
    pkgs.i3
    pkgs.dunst
    pkgs.rofi
    pkgs.wezterm
  ];

  # Enable programs
  programs.zsh.enable = true;
  programs.i3.enable = true;
  programs.i3.extraPackages = [ pkgs.i3blocks ];
  programs.wezterm.enable = true;

  # Optional: Add shell aliases and other settings
  programs.bash.shellAliases = {
    ll = "ls -alF";
    gs = "git status";
  };
}

