{ pkgs, ... }: {
  home.username = "hades";
  home.homeDirectory = "/home/hades";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  programs.neovim.enable = true;
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [

    #Language
    bun
    #############
    rnix-lsp
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted

    bat
    vim
    # btop
    gdu
    nodejs
    # cargo

    #files
    ranger
    fzf
    trash-cli

    # zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    # eza
    neofetch
    unzip
    fzf-zsh
    # tmux

    ##
    direnv
    nix-direnv
    # New
    lazygit
    ripgrep
    man
    jq


  ];
  # #eza
  # programs.eza = {
  #   enable = true;
  #   enableAliases = true;
  # };

  # FISH
  programs.fish = {
    enable = true;
    # shellAbbrs = {
    shellAliases = {
      cp = "cp -iv";
      mv = "mv iv";
      rm = "trash-put";
      cat = "bat";
      vim = "nvim";
      lg = "lazygit";
      mans = '' man -k  . | cut -d " " -f 1 | fzf -m --preview "man {1}" '';
      grep = "rg";

    };
  };

  # STARTSHIP
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };



  ############################ Batas Program

  programs.home-manager.enable = true;
  # font.fontconfig.enable = true;
  # direnv
  imports = [
    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/btop.nix
    ./programs/tmux.nix
    ./programs/shell.nix
    ./setting.nix
    ./programs/tools.nix
    ./programs/nvim.nix

  ];
  programs = {
    direnv = {
      enable = true;
      # enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    bash.enable = true; # see note on other shells below
  };
}
