##################################################################
#                       Development shells
##################################################################

{ pkgs, ... }: {
  default = pkgs.mkShell {
    name = "devshell";
    description = "Development shell";
    buildInputs = [ ];
  };
  bun = pkgs.mkShell {
    buildInputs = [ pkgs.bun ];
  };
  python = pkgs.mkShell {
    buildInputs = [ pkgs.python3 ];
  };
  go = pkgs.mkShell {
    buildInputs = [ pkgs.go ];
  };
  pnpm = pkgs.mkShell {
    description = "Nodejs with PNPM";
    buildInputs = with pkgs;[
      nodejs_21
      (nodePackages.pnpm.override { nodejs = nodejs_21; })
    ];
  };
  node20 = pkgs.mkShell {
    description = "Nodejs 20 Development Evironment";
    buildInputs = with pkgs; [
      nodejs_20
      (nodePackages.yarn.override { nodejs = nodejs_20; })
    ];
  };
  zig = pkgs.mkShell {
    description = "Zig development environment";
    buildInputs = with pkgs; [
      zig
    ];
  };
}
