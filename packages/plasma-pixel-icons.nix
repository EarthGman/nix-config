{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  unstableGitUpdater,
  gtk3,
}:

stdenvNoCC.mkDerivation {
  pname = "plasma-pixel-icons";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "PaulLesur";
    repo = "plasma-pixel-icon-theme";
    rev = "daf7d79c4c9fc3edaa671c5774e3d968f292dd32";
    hash = "sha256-cYfm/LI+pjd5jjNBDODM8uiglhsYN2HdKx8vlp3qgeU=";
  };

  nativeBuildInputs = [ gtk3 ];

  dontDropIconThemeCache = true;
  # TODO fork this guys repo and remove the BS (Broken symlinks ;)
  dontCheckForBrokenSymlinks = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/plasma-pixel-icons
    cp -r Pixel-Theme/* $out/share/icons/plasma-pixel-icons
    gtk-update-icon-cache $out/share/icons/plasma-pixel-icons

    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = with lib; {
    homepage = "https://github.com/PaulLesur/plasma-pixel-icon-theme";
    description = "simple plasma pixel icon theme for linux";
    platforms = platforms.linux;
    maintainers = with maintainers; [ EarthGman ];
  };
}
