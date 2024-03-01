#!/bin/bash

# Lokasi file yang mungkin menyebabkan konflik
BASH_PROFILE="/home/hades/.bash_profile"
BASHRC="/home/hades/.bashrc"

# Fungsi untuk membuat backup file
backup_file() {
    local file_path="$1"
    if [ -f "$file_path" ]; then
        echo "Membuat backup dari $file_path ke ${file_path}.bak"
        mv "$file_path" "${file_path}.bak"
    else
        echo "File $file_path tidak ditemukan, tidak perlu dibackup."
    fi
}

# Periksa konflik untuk file yang mungkin menyebabkan masalah
if [ -f "$BASH_PROFILE" ] || [ -f "$BASHRC" ]; then
    echo "Menemukan file yang mungkin menyebabkan konflik."
    echo "Memproses file yang mungkin menyebabkan konflik..."
    backup_file "$BASH_PROFILE"
    backup_file "$BASHRC"
fi

# Jalankan home-manager build
home-manager build --flake .

# Jalankan home-manager switch
if ! home-manager switch --flake .; then
    echo "Terdapat konflik saat menjalankan home-manager switch."
    echo "Memproses konflik..."
    # Tambahkan kode di sini untuk menangani konflik, misalnya dengan memindahkan atau menghapus file yang menyebabkan konflik
fi

echo "Proses selesai."

