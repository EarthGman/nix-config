{ config, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  # overwrite some default config that is otherwise invasive
  config.stylix = {
    autoEnable = mkDefault false;
    image = mkDefault config.custom.wallpaper;
  };
}
