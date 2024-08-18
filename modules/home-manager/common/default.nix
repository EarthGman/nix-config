{ lib, config, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [
    ./git.nix
    ./packages.nix
    ./options.nix
    #./vnc.nix
  ];
  kitty.enable = mkDefault true;
  firefox.enable = mkDefault true;
  fastfetch.enable = mkDefault true;
  mupdf.enable = mkDefault true;
  switcheroo.enable = mkDefault true;
}
