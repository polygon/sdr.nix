{ lib, stdenv, fetchFromGitHub, qmake, qtbase, pkg-config, sigutils, fftwSinglePrec, suwidgets, wrapQtAppsHook, suscan, libsndfile, soapysdr-with-plugins, libxml2, volk }:

stdenv.mkDerivation rec {
  pname = "sigdigger";
  version = "2022-01-11";

  src = fetchFromGitHub {
    owner = "BatchDrake";
    repo = "SigDigger";
    rev = "0a0576f05a2e3a21aaf3f0e1b6bcdb23d7cbc510";
    sha256 = "0d1r9awp9jr1d7p1l9dg6hsqp9kw9vhrkyyvp09qipwakqac7vis";
  };

  nativeBuildInputs = [
    qmake
    pkg-config
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase
    sigutils
    fftwSinglePrec
    suwidgets
    suscan
    libsndfile
    libxml2
    volk
    soapysdr-with-plugins
  ];

  qmakeFlags = [
    "SUWIDGETS_PREFIX=${suwidgets}"
    "SigDigger.pro"
  ];

  meta = with lib; {
    description = "Qt-based digital signal analyzer, using Suscan core and Sigutils DSP library";
    homepage = "https://github.com/BatchDrake/SigDigger";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ polygon ];
  };
}
