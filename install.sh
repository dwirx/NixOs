#!/bin/bash

nix_installation_done=false

# Check if Nix is already installed
if command -v nix-env &>/dev/null; then
    echo "Nix is already installed. Skipping installation."
else
    # Install Nix
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix_installation_done=true
fi

# Check if experimental features are already enabled in Nix configuration
if grep -q 'experimental-features' /etc/nix/nix.conf; then
    echo "Experimental features are already enabled in Nix configuration."
else
    # Enable experimental features
    echo 'experimental-features = nix-command flakes' | sudo tee -a /etc/nix/nix.conf
    nix_installation_done=true
fi

# Add home-manager channel if not already added
if nix-channel --list | grep -q 'home-manager'; then
    echo "Home-manager channel already added."
else
    # Add home-manager channel
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix_installation_done=true
fi

# Update channels
nix-channel --update

# Check if nixpkgs repository already exists
nixpkgs_dir="$HOME/.config/nixpkgs"
if [ -d "$nixpkgs_dir" ]; then
    echo "nixpkgs repository already exists in $nixpkgs_dir. Skipping clone."
else
    echo "Choose how you want to clone the nixpkgs repository:"
    echo "1. Clone using HTTPS"
    echo "2. Clone using SSH"
    read -rp "Enter your choice: " clone_option

    case $clone_option in
        1)
            echo "Cloning nixpkgs repository using HTTPS..."
            git clone https://github.com/dwirx/nixpkgs.git "$nixpkgs_dir"
            ;;
        2)
            echo "Cloning nixpkgs repository using SSH..."
            git clone git@github.com:dwirx/nixpkgs.git "$nixpkgs_dir"
            ;;
        *)
            echo "Invalid option. Cloning using HTTPS by default."
            echo "Cloning nixpkgs repository using HTTPS..."
            git clone https://github.com/dwirx/nixpkgs.git "$nixpkgs_dir"
            ;;
    esac
fi

# Install home-manager if Nix installation was done or home-manager is not installed
if [ "$nix_installation_done" = true ] || ! command -v home-manager &>/dev/null; then
    nix-shell '<home-manager>' -A install
    echo "Installation completed. Restarting shell..."
    exec bash
else
    echo "No new installation performed. Skipping shell restart."
fi

