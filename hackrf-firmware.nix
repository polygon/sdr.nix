{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  gcc-arm-embedded-10,
  python38,
  board ? "HACKRF_ONE"
}:

stdenv.mkDerivation rec {
  pname = "hackrf-firmware";
  version = "2021.03.1";

  src = fetchFromGitHub {
    owner = "greatscottgadgets";
    repo = "hackrf";
    rev = "v${version}";
    sha256 = "sha256-/rqMt32FwcOZfK2xUYM0pjqvbDP9J0qW3DJbOa9JF+o=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    gcc-arm-embedded-10
    (python38.withPackages (p: with p; [
      pyyaml
    ]))
  ];

  postPatch = ''
    patchShebangs firmware/libopencm3/scripts/
    patchShebangs .
  '';

  cmakeFlags = [
    "-DBOARD=${board}"
  ];

  buildInputs = [
  ];

  installPhase = ''
    mkdir -p $out
    cp hackrf_usb/*.bin $out
    cp hackrf_usb/*.elf $out
  '';

  preConfigure = ''
    cd firmware
  '';
}
