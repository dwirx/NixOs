{
  description = "Hades nix System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # devShells.x86_64-linux = {
      #   default = pkgs.mkShell {
      #     buildInputs = [ ];
      #   };
      #
      #   python = pkgs.mkShell {
      #     buildInputs =
      #       [
      #         pkgs.bat
      #         pkgs.git
      #         pkgs.gdu
      #       ];
      #   };
      # };

      homeConfigurations = {
        hades = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/home.nix ];
        };
      };

      # Mengimpor konfigurasi devShells dari devShells.nix dengan meneruskan pkgs
      devShells.x86_64-linux = import ./devShells.nix { inherit pkgs; };
    };
}
