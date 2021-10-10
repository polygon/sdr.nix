{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  gcc-arm-embedded-10,
  python38,
  gnumake
}:

stdenv.mkDerivation rec {
  pname = "libopencm3";
  version = "6a301c81f4144d72fc881eb4fc7cc77aa1a32a67";

  src = fetchFromGitHub {
    owner = "mossmann";
    repo = "libopencm3";
    rev = "${version}";
    sha256 = "sha256-+R71asywsp0D41KC/d0x1pGNMNkakwrX3Galvti9gAU=";
  };

  postPatch = ''
    patchShebangs scripts/
    substituteInPlace Makefile --replace "/usr/local" "$out"
  '';

  nativeBuildInputs = [
    gnumake
    pkg-config
    gcc-arm-embedded-10
    (python38.withPackages (p: with p; [
      pyyaml
    ]))
  ];

  buildInputs = [
  ];
}
