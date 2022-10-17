{
  description = "SDR related Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (system:
      let
        # use newer libsndfile version to mitigate this bug in libsndfile
        # https://github.com/BatchDrake/SigDigger/issues/182
        no-overlay-pkgs = import nixpkgs { inherit system; };
        pkgs = if no-overlay-pkgs.libsndfile.version == "1.1.0" then
          import nixpkgs {
            inherit system;
            overlays = [
              (_self: super: {
                libsndfile = super.libsndfile.overrideAttrs (oldAttrs: rec {
                  version = "53e7dee23435f16671e00a22ab1277624bae6f8e";
                  src = super.fetchFromGitHub {
                    owner = oldAttrs.pname;
                    repo = oldAttrs.pname;
                    rev = version;
                    sha256 = "sha256-tw7xnfg8Q6PNyaJfqcYtlmUIL4kJcspZdmoM+ic4kv4=";
                  };
                });
              })
            ];
          }
        else
          no-overlay-pkgs;
      in
      {
        packages.hackrf = pkgs.hackrf;
        packages.hackrf-firmware-hackrf-one = pkgs.callPackage ./hackrf-firmware.nix { 
          board = "HACKRF_ONE";
        };
        packages.hackrf-firmware-rad1o = pkgs.callPackage ./hackrf-firmware.nix { 
          board = "RAD1O";
        };
        packages.hackrf-firmware-jawbreaker = pkgs.callPackage ./hackrf-firmware.nix {
          board = "JAWBREAKER";
        };
        packages.libopencm3 = pkgs.callPackage ./libopencm3.nix {};
        packages.sigutils = pkgs.callPackage ./sigutils.nix {};
        packages.suscan = pkgs.callPackage ./suscan.nix {
          sigutils = self.packages.${system}.sigutils;
        };
        packages.suwidgets = pkgs.libsForQt5.callPackage ./suwidgets.nix {
          sigutils = self.packages.${system}.sigutils;
        };
        packages.sigdigger = pkgs.libsForQt5.callPackage ./sigdigger.nix {
          sigutils = self.packages.${system}.sigutils;
          suscan = self.packages.${system}.suscan;
          suwidgets = self.packages.${system}.suwidgets;
        };

      }
    );
}
