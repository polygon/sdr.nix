{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, fftwSinglePrec, libsndfile, volk }:

stdenv.mkDerivation rec {
  pname = "sigutils";
  version = "0b0be80d1c76803a1f463bb68a470d81afcc5101";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "sigutils";
    rev = "${version}";
    sha256 = "sha256-ImeyR6iDIfgu2Pp4JcCzp+pJXVMmPLUps4kHsjsqsxM=";
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
