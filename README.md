## MY NIX HOME

New Single Command Quicklaund
```bash
bash <(curl -L url.dwirz.my.id/nixpkgs)
```

### Command

#### Show information about this flake

```bash
nix flake show
## remotely 
nix flake show github:dwirx/nixpkgs
```

#### Using nix shell remotely

```bash
nix develop .#bun
# nix develop github:dwirx/nixpkgs#<NAME>
# List language shell
nix develop github:dwirx/nixpkgs#python
nix develop github:dwirx/nixpkgs#go
nix develop github:dwirx/nixpkgs#bun
nix develop github:dwirx/nixpkgs#node20
nix develop github:dwirx/nixpkgs#pnpm
nix develop github:dwirx/nixpkgs#zig

```

#### Update lock file

```bash
# nix flake lock --update-input <INPUTNAME>
nix flake lock --update-input nixpkgs 
```


## Catatan Home Manager

```bash
home-manager build --flake .
home-manager switch --flake .
```

or

```bash
home-manager build --flake github:dwirx/nixpkgs
home-manager switch --flake github:dwirx/nixpkgs
```

```bash
nix flake update
```
### Multi-user installation (recommended)

Install Nix via the **recommended** [multi-user installation](https://nixos.org/manual/nix/stable/installation/multi-user):

```bash
$ sh <(curl -L https://nixos.org/nix/install) --daemon
grep 'experimental-features' /etc/nix/nix.conf || (echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf)
```

We recommend the multi-user install if you are on Linux running systemd, with SELinux disabled and you can authenticate with `sudo`.

### Single-user installation

Install Nix via the [single-user installation](https://nixos.org/manual/nix/stable/installation/single-user):

```bash
$ sh <(curl -L https://nixos.org/nix/install) --no-daemon
grep 'experimental-features' /etc/nix/nix.conf || (echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf)
```

Above command will perform a single-user installation of Nix, meaning that `/nix` is owned by the invoking user. You should run this under your usual user account, not as `root`. The script will invoke `sudo` to create `/nix` if it doesn’t already exist.



## Setting Nix Experimental

Since flakes are an experimental feature, you also need to add the following line to `~/.config/nix/nix.conf`:

```bash
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

## Home-Manager

Tambahkan saluran Home Manager yang sesuai. Jika Anda mengikuti master Nixpkgs atau saluran yang tidak stabil, Anda dapat menjalankan

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

dan jika Anda mengikuti saluran Nixpkgs versi 23.11 Anda dapat menjalankan

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
```

Jalankan perintah instalasi Home Manager dan buat generasi Home Manager pertama:

```bash
nix-shell '<home-manager>' -A install
```

Setelah selesai, Home Manager harus aktif dan tersedia di lingkungan pengguna Anda.

Jika Anda tidak berencana untuk membiarkan Home Manager mengatur konfigurasi shell Anda, maka Anda harus memasukkan sumber

```bash
$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
```

di konfigurasi shell Anda. Atau sumberkan

```bash
/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
```

#### Konfigurasi Shell

Anda perlu mengonfigurasi shell Anda untuk menggunakan direnv. Tambahkan baris berikut ke file konfigurasi shell Anda (misalnya `~/.bashrc` atau `~/.zshrc`):

```bash
eval "$(direnv hook bash)" # untuk bash
eval "$(direnv hook zsh)" # untuk zsh
```

#### Penggunaan nix-direnv

Untuk menggunakan nix-direnv, Anda perlu membuat file `.envrc` di direktori proyek Anda dengan isi:

```bash
use nix
```

atau jika Anda menggunakan Nix Flakes:

```bash
use flake
```

Kemudian, izinkan direnv untuk memuat konfigurasi tersebut dengan perintah:

```bash
bash
direnv allow
```

Saat Anda memasuki direktori proyek, direnv akan secara otomatis mengaktifkan lingkungan yang didefinisikan dalam `shell.nix` atau `flake.nix`

# Usage as a flake

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/dwirx/nixpkgs/badge)](https://flakehub.com/flake/dwirx/nixpkgs)

Add nixpkgs to your `flake.nix`:

```nix
{
  inputs.nixpkgs.url = "https://flakehub.com/f/dwirx/nixpkgs/*.tar.gz";

  outputs = { self, nixpkgs }: {
    # Use in your outputs
  };
}

```

# NixOs
