{ pkgs, ... }:
let
  background = ./background.jpg;
in
pkgs.stdenv.mkDerivation {
  name = "hallow-knight";
  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Bluish-Plasma-Themes";
    rev = "5afbd9a22c677d1a8dbafd3d82184f3421d3d27c";
    sha256 = "0an6xba339ihw66rjaf67mhh5j6zmllxkhrv1s9jcrlwfyim6lxp";
  };
  dontWrapQtApps = true;

  installPhase = ''
    THEME_DIR=$out/share/sddm/themes/hallow-knight
    mkdir -p $THEME_DIR
    cp -r ./Bluish\ SDDM\ Themes/Bluish-SDDM/* $THEME_DIR
    rm $THEME_DIR/background.jpg
    cp ${background} $THEME_DIR/background.jpg
  '';
}
