{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "bluish-sddm";
  src = pkgs.fetchFromGitHub {
    owner = "L4ki";
    repo = "Bluish-Plasma-Themes";
    rev = "5afbd9a22c677d1a8dbafd3d82184f3421d3d27c";
    sha256 = "0an6xba339ihw66rjaf67mhh5j6zmllxkhrv1s9jcrlwfyim6lxp";
  };
  dontWrapQtApps = true;

  installPhase = ''
    mkdir -p $out
    cp -R ./Bluish\ SDDM\ Themes/Bluish-SDDM/* $out/
  '';
}
