#!/bin/bash
# Install Nix package manager
echo "Installing Nix..."
curl -L https://nixos.org/nix/install | sh

# Add Home Manager channel and update
echo "Adding Home Manager channel..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Create Home Manager configuration
echo "Setting up Home Manager..."
mkdir -p ~/.config/nixpkgs
curl -L https://github.com/nix-community/home-manager/releases/download/release-23.05/home-manager-23.05-x86_64-linux.tar.xz | tar xJf - -C ~/.config/nixpkgs

# Activate Home Manager
~/.config/nixpkgs/home-manager activate

# Run home-manager to apply the configuration
home-manager switch

