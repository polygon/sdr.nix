{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, fftwSinglePrec, libsndfile, sigutils, soapysdr-with-plugins, libxml2, volk }:

stdenv.mkDerivation rec {
  pname = "suscan";
  version = "2022-01-04";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "suscan";
    rev = "052302ba995a73ab6c05b97b2c8a57c57ed31edc";
    sha256 = "1m6m1j4vgndg65xz7sjjg3dkksaj2cnn93xjnqqmaq4cq36ivga7";
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
