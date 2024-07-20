{ stdenv, fetchFromGitHub, pkgs, ... }:
stdenv.mkDerivation {
  name = "afterglow";
  src = fetchFromGitHub {
    owner = "yeyushengfan258";
    rev = "2d137791dedc4db8bbf122cb0eec01212266c13f";
    repo = "Afterglow-kde";
    sha256 = "00pqsqcvsw3h3r61lqj9j06iv2r70qs4280pf1dxbd8h7j703i48";
  };
  buildInputs = [
    pkgs.gzip
  ];
  # installPhase = ''
  #   mkdir -p $out
  #   cp -r ./sddm-dark/Afterglow-dark/* $out/share/sddm/themes/afterglow-dark
  # '';
  installPhase = ''
    runHook preInstall
    THEME_DIR=$out/share/sddm/themes/afterglow
    mkdir -p $THEME_DIR
    pushd ./sddm-dark/Afterglow-dark/assets
    for file in *.svgz; do mv "$file" "''${file/svgz/svg.gz}"; done
    ${pkgs.gzip}/bin/gunzip *.svg.gz
    popd
    cp -r ./sddm-dark/Afterglow-dark/* $THEME_DIR
    sed -i "s|\.svgz|\.svg|g" $THEME_DIR/Main.qml
    sed -i "s|\.svgz|\.svg|g" $THEME_DIR/Login.qml
    sed -i "s|/usr/share/sddm/themes/Afterglow-dark/assets|assets|g" $THEME_DIR/Main.qml
    runHook postInstall
  '';
}
