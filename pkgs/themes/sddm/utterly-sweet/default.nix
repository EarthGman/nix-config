{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "utterly-sweet";
  src = pkgs.fetchFromGitHub {
    owner = "HimDek";
    repo = "Utterly-Sweet-Plasma";
    rev = "bb098dc35fb146c5045492e3225f9b2e2f4dc16c";
    sha256 = "01k0rrm56yxxcgdx3a20xgzw291q9ps268jl3ngg3pkcrrazvlz1";
  };
  dontWrapQtApps = true;

  installPhase = ''
    THEME_DIR=$out/share/sddm/themes/utterly-sweet
    mkdir -p $THEME_DIR
    cp -R ./sddm/* $THEME_DIR
  '';
}
