{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "flight-sddm";
  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Flight-Plasma-Themes";
    rev = "1a49a9f04dbf200807f021c102a77fce5aa81981";
    sha256 = "0b703zjm446hxq3y4px8d4n6xla1lpplcik23rwfanfzqp1ygw65";
  };
  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out
    cp -R ./Flight\ SDDM\ Themes/Flight-SDDM/* $out/
  '';
}
