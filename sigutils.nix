{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, fftwSinglePrec, libsndfile, volk }:

stdenv.mkDerivation rec {
  pname = "sigutils";
  version = "2021-12-10";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "sigutils";
    rev = "982d4ce1818905b097ecdf406733c2ef099f7b35";
    sha256 = "0073b07pzvp2h782rvpm12954l2ff1cc452z8pdspqd321sn8dl2";
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

  meta = with lib; {
    description = "Small signal processing utility library";
    homepage = "https://github.com/BatchDrake/sigutils";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ polygon ];
  };
}
