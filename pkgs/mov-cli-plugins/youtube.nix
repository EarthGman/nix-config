{ pkgs, ... }:
let
  python3Packages = pkgs.python3Packages.override {
    overrides = final: prev: {
      pytubefix8 = prev.pytubefix.overridePythonAttrs (old: rec {
        version = "8.8.1";
        src = pkgs.fetchFromGitHub {
          # unfortunately cant just override the version (would be nice though)
          owner = "JuanBindez";
          repo = "pytubefix";
          rev = "refs/tags/v${version}";
          hash = "sha256-0ukh+739uvg33lsai8Mu88yMnS036LVLY1MXklAArsc=";
        };
        doCheck = false; # test fails to resolve domain name lol
      });
    };
  };
in

python3Packages.buildPythonPackage {
  pname = "mov-cli-youtube";
  version = "1.3.5";
  pyproject = true;

  src = pkgs.fetchFromGitHub {
    owner = "mov-cli";
    repo = "mov-cli-youtube";
    rev = "9040c1276af08d25d6977aa33a8a408f7d733324";
    hash = "sha256-cJQGLaGubhtvWEPhe5NpTeLGXlMjUhKU2I5+z8pMWVw=";
  };

  dependencies = with python3Packages; [
    setuptools
    pytubefix8
    requests
    yt-dlp
  ];
}
