{ inputs, stdenvNoCC, ... }:
let
  fonts = builtins.fromJSON (builtins.readFile inputs.fonts.outPath);
in
stdenvNoCC.mkDerivation {
  pname = "omori-font";
  version = "1.0";

  src = builtins.fetchurl fonts.omori-2;
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/share/fonts
    cp $src $out/share/fonts/omori-2.ttf
  '';
}
