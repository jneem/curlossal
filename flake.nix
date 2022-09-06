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
      pypiDataRev = "master";
      #pypiDataSha256 = "1b8wwrlwpgyg9s9mnikv7c40ml9c1n32c8qz9apxb0538qchwcc5";
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
      mach-nix-wrapper = import mach-nix { inherit pkgs python pypiDataRev; };
      requirements = builtins.readFile ./requirements.txt;
      pythonShell = mach-nix-wrapper.mkPythonShell {
        inherit requirements;
      };
      pythonEnv = mach-nix-wrapper.mkPython {
        inherit requirements;
      };
      mergeEnvs = envs:
        pkgs.mkShell (builtins.foldl' (a: v: {
          # runtime
          buildInputs = a.buildInputs ++ v.buildInputs;
          # build time
          nativeBuildInputs = a.nativeBuildInputs ++ v.nativeBuildInputs;
        }) (pkgs.mkShell { }) envs);
    in {
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
          mkdir -p $out/share/cursors
          install -m 0755 out/cursors/* $out/share/cursors
        '';
      };
    });
}