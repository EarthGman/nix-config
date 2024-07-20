{ pkgs, ... }:

let
  image = ./background.jpg;
in
pkgs.stdenv.mkDerivation {
  name = "april";
  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Bluish-Plasma-Themes";
    rev = "5afbd9a22c677d1a8dbafd3d82184f3421d3d27c";
    sha256 = "0an6xba339ihw66rjaf67mhh5j6zmllxkhrv1s9jcrlwfyim6lxp";
  };
  dontWrapQtApps = true;

  installPhase = ''
    THEME_DIR=$out/share/sddm/themes/april
    mkdir -p $THEME_DIR
    cp -R ./Bluish\ SDDM\ Themes/Bluish-SDDM/* $THEME_DIR
    sed -i "s|/usr/share/sddm/themes/Bluish-SDDM/components|components|g" $THEME_DIR/*.qml
    sed -i "s|/usr/share/sddm/themes/Bluish-SDDM/||g" $THEME_DIR/theme.conf
    rm $THEME_DIR/background.jpg
    cp ${image} $THEME_DIR/background.jpg
  '';
}
