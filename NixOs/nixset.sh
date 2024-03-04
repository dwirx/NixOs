#!/bin/bash

echo "Selamat datang, Hendra!"

# Menampilkan pilihan untuk pengunduhan
echo "Silakan pilih opsi pengunduhan:"
echo "1. Hardware Configuration"
echo "2. Configuration"

# Membaca input dari pengguna
read -p "Masukkan nomor pilihan (1 atau 2): " option

# Menentukan URL berdasarkan pilihan
case $option in
  1)
    url="https://raw.githubusercontent.com/dwirx/NixOs/master/hardware-configuration.nix"
    ;;
  2)
    url="https://raw.githubusercontent.com/dwirx/NixOs/master/configuration.nix"
    ;;
  *)
    echo "Pilihan tidak valid. Keluar."
    exit 1
    ;;
esac

# Menentukan nama file untuk disimpan
filename=$(basename $url)

# Menentukan path untuk menyimpan file
filepath="/mnt/etc/nixos/$filename"

# Mengunduh file dengan curl dan menyimpannya di direktori yang ditentukan
curl -o "$filepath" $url

echo "Pengunduhan selesai. File disimpan di: $filepath"
