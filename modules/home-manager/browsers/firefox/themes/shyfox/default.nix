{ pkgs, ... }:
let
  profileDir = ".mozilla/firefox/${username}";
  shyFoxRepo = pkgs.fetchFromGitHub {
    owner = "Naezr";
    repo = "ShyFox";
    rev = "main";
    sha256 = "04zwfacnz3wfmabmbawgg523s6qyxszjcafgl2qahn1j30rsxxl1";
  };
  user_js = "${shyFoxRepo}/user.js";
  chrome = "${shyFoxRepo}/chrome";
in
{
  home.file = {
    "${profileDir}/chrome".source = chrome;
    "${profileDir}/user.js".source = user_js;
  };
}
