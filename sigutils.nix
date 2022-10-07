{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, fftwSinglePrec, libsndfile, volk }:

stdenv.mkDerivation rec {
  pname = "sigutils";
  version = "2021-12-10";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "sigutils";
    rev = "1d7559d427aadd253dd825eef26bf15e54860c5f";
    sha256 = "sha256-wvd6sixwGmR9R4x+swLVqXre4Dqnj10jZIXUfaJcmBw=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    fftwSinglePrec
    libsndfile
    volk
  ];

  preConfigure = ''
    sed -i 's/util\/compat-/sys\//' sigutils/log.c
  '';

  meta = with lib; {
    description = "Small signal processing utility library";
    homepage = "https://github.com/BatchDrake/sigutils";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ polygon ];
  };
}
