{
  description = "Basic rust dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix.url = "github:nix-community/fenix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, fenix, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ fenix.overlays.default ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        rust-toolchain = pkgs.fenix.latest.withComponents [
          "cargo"
          "clippy"
          "rustc"
          "rustfmt"
          "rust-analyzer"
          "rust-src"
        ];

        nickel-cursor = pkgs.rustPlatform.buildRustPackage {
          pname = "nickel-cursor";
          version = "0.1.0";

          src = pkgs.lib.sources.sourceByRegex ./. ["Cargo\.*" "src" "src/.*"];
          cargoLock = {
            lockFile = ./Cargo.lock;
          };
        };

        curlossal = pkgs.stdenv.mkDerivation {
          pname = "curlossal";
          version = "0.2.0";
          src = pkgs.lib.sources.sourceByRegex ./. [".*\.ncl"];

          buildInputs = [ nickel-cursor ];

          buildPhase = ''
            ${nickel-cursor}/bin/nickel-cursor curlossal.ncl --out $out/share/icons/
          '';
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            cargo-outdated
            nickel
            nls
            rust-toolchain
          ];
        };

        packages.nickel-cursor = nickel-cursor;
        packages.default = curlossal;
      }
    );
}
