{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.flatpak;
in
{
  options.gman.flatpak = {
    enable = lib.mkEnableOption "gman's flatpak module with automatic flathub setup";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = lib.mkDefault true;
    # flatpak frontend
    programs.gnome-software.enable = lib.mkDefault true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
