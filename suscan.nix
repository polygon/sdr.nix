{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, fftwSinglePrec, libsndfile, sigutils, soapysdr-with-plugins, libxml2, volk }:

stdenv.mkDerivation rec {
  pname = "suscan";
  version = "2022-07-05";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "suscan";
    rev = "37dad542b97aff24654f0bb80fb8e85af7cb84ab";
    sha256 = "sha256-h1ogtYjkqiHb1/NAJfJ0HQIvGnZM2K/PSP5nqLXUf9M=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    fftwSinglePrec
    libsndfile
    sigutils
    soapysdr-with-plugins
    libxml2
    volk
  ];

  preConfigure = ''
    sed -i 's/fftw3 >= 3.0/fftw3f >= 3.0/' suscan.pc.in;
  '';

  patchPhase = ''
  '';
  meta = with lib; {
    description = "Channel scanner based on sigutils library";
    homepage = "https://github.com/BatchDrake/suscan";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ polygon ];
  };
}
