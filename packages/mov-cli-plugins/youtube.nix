{ lib
, python3Packages
, fetchFromGitHub
, ...
}:

python3Packages.buildPythonPackage rec {
  pname = "mov-cli-youtube";
  version = "1.3.8";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "mov-cli";
    repo = "mov-cli-youtube";
    rev = "${version}";
    hash = "sha256-2dc6EYy+6vCOCy+FZBVKWzeV3xFAswUaX9XfYk0jz1E=";
  };

  dependencies = with python3Packages; [
    setuptools
    pytubefix
    requests
    yt-dlp
  ];

  meta = with lib; {
    description = "Youtube plugin for mov-cli";
    homepage = "https://github.com/mov-cli/mov-cli-youtube";
    license = licenses.mit;
    platforms = [
      "x86_64-linux"
      "aarch64_linux"
      "aarch64_darwin"
    ];
    # maintainers = [ maintainers.EarthGman ];
  };
}
