{pkgs, ... }: {
    
  home.packages = with pkgs; [
  #Rust 
  rust-script
  protoc-gen-doc
  protoc-gen-rust
  yarn
  quick-lint-js
  rustup
  sumneko-lua-language-server
  nodePackages.diagnostic-languageserver
  nodePackages.bash-language-server
  clang
  clang-tools
  ];

}
