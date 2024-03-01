## direnv dan nix-direnv

`direnv` memungkinkan saya mengontrol pengaturan lingkungan pengembangan tingkat direktori dengan file `.envrc`. Tetapi saya ingin menggunakan ini dengan flake nix. Untungnya ada proyek komunitas yang sudah ada dengan integrasi nix dan direnv, yaitu nix-direnv.

Dengan home-manager, sangat mudah untuk mengintegrasikan nix-direnv dengan sistem saya saat ini.

```
@@ -5,5 +5,7 @@ in
   home.username = user.name;
   home.homeDirectory = user.homeDir;
   home.stateVersion = "22.11";
+
+  programs.direnv.enable = true;
 }
```

Setelah file diperbarui, sekarang kita perlu menjalankan perintah `hms` (home-manager switch) kita.

Kita dapat memverifikasi instalasi kita dengan menjalankan `direnv` dari terminal.

```
direnv --version
2.32.1
```

Sekarang, setelah dirnev terinstal, saatnya bagi kita untuk menguji setup direnv kita.

Saya ingin menyiapkan proyek nodejs menggunakan express NodeJs versi 18.x LTS.

1. Buat direktori proyek
2. Tambahkan flake.nix
3. Perbarui flake.nix untuk menarik nodejs 18.x
4. Tambahkan .envrc
5. Jalankan `direnv allow`

```
mkdir -p nodejs-21-example
cd nodejs-21-example
```
### Donwload
```bash
curl -O https://raw.githubusercontent.com/dwirx/nixpkgs/main/template/flake.nix
```
Kemudian, kita akan menambahkan flake.nix berikut di root dari nodejs-21-example

```nix
{
  description = "A Nix-flake-based development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [nodejs_21];
        };
      });
    };
}
```

Sebelum kita melanjutkan lebih jauh, file flake.nix harus di-commit ke git.

```
git add flake.nix
git commit -am "Add flake.nix"
```

Setelah file flake.nix di-commit, kita akan menambahkan file `.envrc` dengan konten berikut:

```
use flake
```

Setelah kedua file berhasil ditambahkan, kita akan melihat pesan kesalahan berikut:

Jalankan `direnv allow` agar direnv dapat melakukan tugasnya.

Sekarang, nix dan direnv akan melakukan keajaiban mereka, dan mengunduh nodejs untuk kita.

```
node --version
```

Selama file flake.lock dan flake.nix tidak berubah, nodejs-18-express akan selalu menggunakan versi nodejs yang sama tidak peduli siapa yang memasuki proyek ini. Keren
