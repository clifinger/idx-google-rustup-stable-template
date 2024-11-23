{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.rustup # Utilisation de rustup pour gérer les toolchains Rust
    pkgs.stdenv.cc
  ];

  # Sets environment variables in the workspace
  env = {
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

    # Initialisation de rustup et création d'une bibliothèque Rust
  };

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "rust-lang.rust-analyzer"
      "tamasfe.even-better-toml"
      "serayuzgur.crates"
      "vadimcn.vscode-lldb"
    ];
    workspace = {
      onCreate = {
        start-rustup-toolchain-download = "rustup toolchain install stable";
        start-rustup-default-toolchain = "rustup default stable";
        create-lib = ''
          if [ ! -f "Cargo.toml" ]; then
             cargo init
           fi
        '';
        default.openFiles = [ "src/lib.rs" ];
      };
      onStart = {
        default.openFiles = [ "src/main.rs" ];
      };
    };

    # Enable previews and customize configuration
    previews = { };
  };
}
