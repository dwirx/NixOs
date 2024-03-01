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


## Home Manager Notes

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

Add the appropriate Home Manager channel. If you follow the master Nixpkgs or an unstable channel, you can run

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

and if you follow the Nixpkgs version 23.11 channel, you can run

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
```

Run the Home Manager installation command and create the first Home Manager generation:

```bash
nix-shell '<home-manager>' -A install
```

Once done, Home Manager should be active and available in your user environment.

If you don't plan to let Home Manager manage your shell configuration, then you should source

```bash
$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
```

into your shell configuration. Or source

```bash
/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh
```

#### Shell Configuration

You need to configure your shell to use direnv. Add the following line to your shell configuration file (e.g., `~/.bashrc` or `~/.zshrc`):

```bash
eval "$(direnv hook bash)" # for bash
eval "$(direnv hook zsh)" # for zsh
```

#### Using nix-direnv

To use nix-direnv, you need to create a `.envrc` file in your project directory with the content:

```bash
use nix
```

or if you're using Nix Flakes:

```bash
use flake
```

Then, allow direnv to load that configuration with the command:

```bash
bash
direnv allow
```

When you enter the project directory, direnv will automatically activate the environment defined in `shell.nix` or `flake.nix`

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
