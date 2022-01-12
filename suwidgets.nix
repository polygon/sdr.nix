{ lib, stdenv, fetchFromGitHub, qmake, qtbase, pkg-config, sigutils, fftwSinglePrec }:

stdenv.mkDerivation rec {
  pname = "suwidgets";
  version = "2022-01-09";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "SuWidgets";
    rev = "eff320056984a979079b8c4d98db762b7f524557";
    sha256 = "1ag58xy7z9m59g773j767bb9d40y0pf547ws7xgid2rmhkifnpbd";
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
