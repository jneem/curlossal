{
  description = "Basic rust dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nickel-cursor = {
      url = "github:jneem/nickel-cursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, nickel-cursor, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        ncursor = nickel-cursor.packages.${system}.default;

        curlossal = pkgs.stdenv.mkDerivation {
          pname = "curlossal";
          version = "0.2.0";
          src = pkgs.lib.sources.sourceByRegex ./. [".*\.ncl"];
          NICKEL_IMPORT_PATH = ncursor;

          buildInputs = [ ncursor ];

          buildPhase = ''
            ${ncursor}/bin/nickel-cursor curlossal.ncl --out $out/share/icons/
          '';
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
          buildInputs = [
            nickel
            nls
            ncursor
          ];
          NICKEL_IMPORT_PATH = ncursor;
        };

        packages.default = curlossal;
      }
    );
}
