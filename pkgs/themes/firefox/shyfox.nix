{ pkgs, lib, stdenvNoCC, themeConfig ? null }:
stdenvNoCC.mkDerivation rec {
  pname = "shyfox";
  version = "3.8";

  src = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "8d0d0139bbdb538a64e5a05df907160c39c8f008";
    hash = "sha256-k3p8VxFpI/jw1TLBOKskH4KylsiiWBJLRNpffm+w7Bo=";
  };

  inherit (themeConfig) wallpaper;

  installPhase = ''  
    rm -f *.md LICENSE
    mkdir -p $out
    cp -r ./* $out
  '' + lib.optionalString (wallpaper != null) ''
    cd $out
    rm -f chrome/wallpaper.png
    ln -sf ${wallpaper} chrome/wallpaper.png
  '';
}
