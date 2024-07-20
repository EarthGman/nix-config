{ pkgs }:

let
  background = ./background.jpg;
in
pkgs.stdenv.mkDerivation {
  name = "sugar-dark";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    THEME_DIR=$out/share/themes/sugar-dark
    mkdir -p $THEME_DIR
    cp -R ./* $THEME_DIR
    rm $THEME_DIR/Background.jpg
    cp -r ${background} $THEME_DIR/background.jpg
  '';
}
