{ pkgs, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation {
  pname = "betterfox";
  version = "133.0";

  src = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "main";
    sha256 = "sha256-Uu/a5t74GGvMIJP5tptqbiFiA+x2hw98irPdl8ynGoE=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
