{ pkgs
, vimUtils
}:

vimUtils.buildVimPlugin {
  name = "direnv-nvim";

  src = pkgs.fetchFromGitHub {
    owner = "NotAShelf";
    repo = "direnv.nvim";
    rev = "4dfc8758a1deab45e37b7f3661e0fd3759d85788";
    hash = "sha256-KqO8uDbVy4sVVZ6mHikuO+SWCzWr97ZuFRC8npOPJIE=";
  };
}
