{ pkgs, lib, stdenvNoCC, themeConfig ? null }:
stdenvNoCC.mkDerivation rec {
  pname = "shyfox";
  version = "3.8.1";

  src = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "bd41f885f19771b12e23c522ccaafe33af59a1c7";
    hash = "sha256-w4kaOjz51FYYS58TrPVI/OgZ8At9mbPXj2G3X/N7Lu8=";
  };

  wallpaper =
    if (builtins.hasAttr "wallpaper" themeConfig) then
      themeConfig.wallpaper
    else
      null;

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
