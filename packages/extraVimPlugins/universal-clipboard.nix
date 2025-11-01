# https://github.com/swaits/universal-clipboard.nvim
{ pkgs
, vimUtils
, ...
}:

vimUtils.buildVimPlugin {
  name = "nvim-universal-clipboard";

  src = pkgs.fetchFromGitHub {
    owner = "swaits";
    repo = "universal-clipboard.nvim";
    rev = "48a625ab592633a05446ef66031611593a5b55d9";
    hash = "sha256-YnZ9VJj2Mr45ku6WaF897FCmIFeI4Sj2F31iyzSUY9E=";
  };
}

