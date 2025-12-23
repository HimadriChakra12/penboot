#!/bin/bash
# Packages
packages=(
    "wezterm"
)
shell=(
    "github-cli"
    "lazygit"
    "tmux"
    "7zip"
    "vim"
    "fzf"
    "kde-cli-tools"
    "mpv"
)

# Capture --noconfirm flag from argument
NOCONFIRM_FLAG="$1"

# Function to install a category
install_category() {
    local category_name="$1"
    shift
    local packages_list=("$@")
    
    echo "Installing $category_name..."
    if [ ${#packages_list[@]} -eq 0 ]; then
        echo "No packages to install for $category_name."
        return
    fi

    sudo pacman -S ${NOCONFIRM_FLAG} "${packages_list[@]}"
}

sudo pacman -Sy
# Install categories
install_category "Shell tools" "${shell[@]}"
install_category "Other Packages" "${packages[@]}"
