{ config, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  imports = [ ./zed.nix ];
  options.custom.zed.enable = lib.mkEnableOption "enable zed module";
  config = lib.mkIf config.custom.zed.enable {
    programs.zed = {
      enable = true;
      settings = {
        theme = mkDefault "Ayu Dark";
        vim_mode = mkDefault false;
        ui_font_size = mkDefault 24;
        buffer_font_size = mkDefault 18;
        tab_size = mkDefault 2;
        auto_update = false;
      };
    };
  };
}
