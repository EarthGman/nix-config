{
  pkgs,
  lib,
  stdenvNoCC,
  themeConfig ? null,
}:
stdenvNoCC.mkDerivation rec {
  pname = "shyfox";
  version = "3.8.1";

  src = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "main";
    hash = "sha256-y/Md0VR8h4n4+xzqfVNy7ARf/NG45T440dpHvC5KkkA=";
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
  ''
  + lib.optionalString (wallpaper != null) ''
    cd $out
    rm -f chrome/wallpaper.png
    ln -sf ${wallpaper} chrome/wallpaper.png
  '';
}
