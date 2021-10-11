{
  description = "SDR related Nix packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachSystem ["x86_64-linux" "aarch64-linux"] (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
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
