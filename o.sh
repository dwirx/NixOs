#!/bin/bash
# input email dari pengguna
read -p "Masukkan email Git Anda: " email
git config --global user.email "$email"

# Meminta input nama dari pengguna
read -p "Masukkan username Git Anda: " name
git config --global user.name "$name"

echo "Konfigurasi global Git telah diatur:"
echo "Email: $email"
echo "username: $name"

