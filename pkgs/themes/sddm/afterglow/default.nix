{ stdenv, fetchFromGitHub, ... }:
stdenv.mkDerivation {
  name = "afterglow";
  src = fetchFromGitHub {
    owner = "yeyushengfan258";
    rev = "2d137791dedc4db8bbf122cb0eec01212266c13f";
    repo = "Afterglow-kde";
    sha256 = "00pqsqcvsw3h3r61lqj9j06iv2r70qs4280pf1dxbd8h7j703i48";
  };
  installPhase = ''
    mkdir -p $out
    cp -r ./sddm-dark/Afterglow-dark/* $out
  '';
}
