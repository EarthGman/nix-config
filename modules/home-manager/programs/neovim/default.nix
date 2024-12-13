{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
  neovim = inputs.vim-config.homeManager;
in
{
  imports = [ neovim.default ];
  stylix.targets.neovim.enable = mkDefault false;
}
