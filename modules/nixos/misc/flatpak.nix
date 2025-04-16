{ pkgs, lib, config, ... }:
{
  options.modules.flatpak.enable = lib.mkEnableOption "enable flatpak for nixos";
  config = lib.mkIf config.modules.flatpak.enable {
    services.flatpak.enable = true;
    environment.systemPackages = with pkgs; [
      gnome-software # good flatpak GUI frontend
    ];
  };
}
