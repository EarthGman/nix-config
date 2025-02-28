{ inputs, lib, platform, ... }:
let
  inherit (lib) mkDefault mkForce;
in
{
  programs.neovim.enable = false;
  home.packages = [ inputs.vim-config.packages.${platform}.default ];
}
