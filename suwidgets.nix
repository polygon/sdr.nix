{ lib, stdenv, fetchFromGitHub, qmake, qtbase, pkg-config, sigutils, fftwSinglePrec }:

stdenv.mkDerivation rec {
  pname = "suwidgets";
  version = "c45b2af3b24115335bf993671198f419fa3ed0f7";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "SuWidgets";
    rev = "${version}";
    sha256 = "sha256-p+kgmtDWuBLlh8IJP5FeximeJSfz9M6Il3SRYz0TJgI=";
  };

  dontWrapQtApps = true;

  nativeBuildInputs = [
    qmake
    pkg-config
  ];

  buildInputs = [
    qtbase
    sigutils
    fftwSinglePrec
  ];

  preConfigure = ''
    sed -i 's/PKGCONFIG += sigutils fftw3/PKGCONFIG += sigutils fftw3f/' SuWidgets.pri
  '';

  qmakeFlags = [
    "SuWidgetsLib.pro"
  ];

  meta = with lib; {
    description = "Sigutils-related widgets";
    homepage = "https://github.com/BatchDrake/SuWidgets";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ polygon ];
  };
}
