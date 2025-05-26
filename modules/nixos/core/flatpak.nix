{ lib, config, ... }@args:
let
  desktop = if args ? desktop then args.desktop else null;
  inherit (lib) mkDefault;
in
{
  options.modules.flatpak.enable = lib.mkEnableOption "enable flatpak for nixos";
  config = lib.mkIf config.modules.flatpak.enable {
    services.flatpak.enable = true;
    programs.gnome-software.enable = mkDefault desktop != null;
  };
}
