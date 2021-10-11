{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, fftwSinglePrec, libsndfile, sigutils, soapysdr-with-plugins, libxml2, volk }:

stdenv.mkDerivation rec {
  pname = "suscan";
  version = "09fd8cf1f220ae707a877107163515114d9eb671";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "suscan";
    rev = "${version}";
    sha256 = "sha256-KU3JaGIL65LWJWc6Iw/eyKdUMnVQ85g0MtmuSPGdp44=";
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
    sed -i 's/fftw3 >= 3.0/fftw3f >= 3.0/' suscan.pc.in
  '';

  meta = with lib; {
    description = "Channel scanner based on sigutils library";
    homepage = "https://github.com/BatchDrake/suscan";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ polygon ];
  };
}
