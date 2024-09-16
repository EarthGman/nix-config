{ lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [ ./zed.nix ];
  programs.zed = {
    settings = {
      theme = mkDefault "Ayu Dark";
      vim_mode = mkDefault false;
      ui_font_size = mkDefault 24;
      buffer_font_size = mkDefault 18;
      tab_size = mkDefault 2;
      auto_update = false;
    };
  };
}
