{ pkgs, lib, stdenvNoCC, themeConfig ? null }:
stdenvNoCC.mkDerivation rec {
  pname = "shyfox";
  version = "3.8.1";

  src = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "main";
    hash = "sha256-7H+DU4o3Ao8qAgcYDHVScR3pDSOpdETFsEMiErCQSA8=";
  };

  wallpaper =
    if (builtins.isAttrs themeConfig && builtins.hasAttr "wallpaper" themeConfig) then
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
