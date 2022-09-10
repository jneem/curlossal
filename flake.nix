{
  description = "Flake to manage python workspace";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
    mach-nix.url = "github:DavHau/mach-nix";
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Customize starts
        python = "python310";
        pypiDataRev = "ae0603a7015ad8824a66479c32ea64429f932c7a";
        pypiDataSha256 = "1hzmzwcha46n7b4503daf666gqrszmwrqfkjs96dzq8xc8wxwzrx";
        devShell = pkgs:
          pkgs.mkShell {
            buildInputs = with pkgs; [
              (pkgs.${python}.withPackages
                (ps: with ps; [ pip black pyflakes isort ]))
              nodePackages.pyright
              nodePackages.prettier
              python310Packages.python-lsp-server
              resvg
            ];
          };
        # Customize ends

        pkgs = nixpkgs.legacyPackages.${system};
        mach-nix-wrapper = import mach-nix { inherit pkgs python pypiDataRev pypiDataSha256; };
        requirements = builtins.readFile ./requirements.txt;
        pythonShell = mach-nix-wrapper.mkPythonShell {
          inherit requirements;
        };
        pythonEnv = mach-nix-wrapper.mkPython {
          inherit requirements;
        };
        mergeEnvs = envs:
          pkgs.mkShell (builtins.foldl'
            (a: v: {
              # runtime
              buildInputs = a.buildInputs ++ v.buildInputs;
              # build time
              nativeBuildInputs = a.nativeBuildInputs ++ v.nativeBuildInputs;
            })
            (pkgs.mkShell { })
            envs);
      in
      {
        devShells.default = mergeEnvs [ (devShell pkgs) pythonShell ];


        packages.default = pkgs.stdenv.mkDerivation {
          pname = "curlossal";
          version = "0.1.0";
          src = self;

          buildInputs = with pkgs; [
            resvg
            pythonEnv
          ];

          buildPhase = ''
            mkdir -p out/cursors
            python src/build.py
          '';

          installPhase = ''
            install -dm 0755 $out/share/icons/Curlossal/cursors
            cp out/cursors/* $out/share/icons/Curlossal/cursors
            cp index.theme cursor.theme $out/share/icons/Curlossal/
          '';
        };
      });
}
