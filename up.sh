#!/bin/bash

# Menjalankan home-manager build dengan flake
home-manager build --flake .

# Menjalankan home-manager switch dengan flake
home-manager switch --flake .

