# lib.nix
{ pkgs, system }: {
  legacyPackages = {
    x86_64-linux = pkgs;
    # Definisikan sistem lain jika diperlukan
  };
}

