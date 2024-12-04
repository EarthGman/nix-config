{ inputs, lib, ... }:
let
  inherit (lib) mkDefault;
  neovim = inputs.vim-config.homeManagerModule;
in
{
  imports = [ neovim.default ];
  stylix.targets.neovim.enable = mkDefault false;
}
