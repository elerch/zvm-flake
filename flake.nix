{
  description = "Downloads/compiles/installs clipboard-upload and clipboard-download";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
        # Replace with the actual GitHub repository URL and revision
        mod = pkgs.buildGoModule {
          pname = "zvm";
          name = "zvm";
          vendorHash = "sha256-hh8dZLnACEdYpXwOVY1jgYgvnzsK1voSBNdKnjWNQ/I=";
          src = pkgs.fetchFromGitHub {
            owner = "elerch";
            repo = "zvm";
            rev = "24f0654996a951324aac76bfb8745d293eae63c6";
            hash = "sha256-t/+J0cU/DrJfQC8uIEpTLUuZrifYc5KU5rHvckRHp3w=";
          };
        };

      in {
        packages.default = mod;
        # packages.default = pkgs.stdenv.mkDerivation {
        #   pname = "zvm";
        #   version = "0.8.4";
        #
        #   # inherit src;
        #
        #   buildInputs = with pkgs; [ go go-tools ];
        #
        #   buildPhase = ''
        #     mkdir -p $out/bin
        #   '';
        #
        #   installPhase = ''
        #   '';
        # };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ go go-tools ];
        };
      }
    );
}
