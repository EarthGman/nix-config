{ pkgs, stdenvNoCC, ... }:

stdenvNoCC.mkDerivation rec {
  pname = "betterfox";
  version = "142.0";

  src = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "${version}";
    hash = "sha256-3xvZAMPdGfj8w2AaepWW5xAX05Ry+pN8peLMORKNTIc=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';
}
