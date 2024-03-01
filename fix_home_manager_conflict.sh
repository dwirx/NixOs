#!/bin/bash

# Lokasi file yang mungkin menyebabkan konflik
BASH_PROFILE="/home/hades/.bash_profile"
BASHRC="/home/hades/.bashrc"

# Fungsi untuk membuat backup file
backup_file() {
    local file_path=$1
    if [ -f "$file_path" ]; then
        echo "Membuat backup dari $file_path ke ${file_path}.bak"
        mv "$file_path" "${file_path}.bak"
    else
        echo "File $file_path tidak ditemukan, tidak perlu dibackup."
    fi
}

# Membuat backup dari .bash_profile dan .bashrc
backup_file "$BASH_PROFILE"
backup_file "$BASHRC"

# Menjalankan home-manager switch dengan opsi backup
#echo "Menjalankan home-manager switch dengan opsi -b backup..."
#home-manager switch --flake . -b backup

echo "Proses selesai."
