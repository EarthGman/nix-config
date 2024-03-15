{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "vivid-sddm";
  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Vivid-Plasma-Themes";
    rev = "21d3ae5448b7508237d004754fc94e570fc76679";
    sha256 = "0x7b6dm27rfafssd9ckaznrgz9p0wq68i2f5cd9wjamvlxjvl16b";
  };
  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out
    cp -R ./Vivid\ SDDM\ Themes/Vivid-SDDM/* $out/
  '';
}
