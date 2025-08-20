{
  lib,
  config,
  ...
}:
{
  imports = lib.autoImport ./.;

  options.gman.server.enable = lib.mkEnableOption "gman's configuration for a server";

  config = lib.mkIf config.gman.server.enable {
    gman = {
      debloat.enable = true;
    };

    boot.loader = {
      grub.enable = false;
      systemd-boot = {
        enable = lib.mkDefault true;
        configurationLimit = lib.mkDefault 2;
      };
    };

    # remove emergency mode
    boot.initrd.systemd.suppressedUnits = lib.mkIf config.systemd.enableEmergencyMode [
      "emergency.service"
      "emergency.target"
    ];
    systemd = {
      enableEmergencyMode = false;
      sleep.extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
      '';
    };

    networking.firewall.enable = true;

    services.openssh = {
      settings = {
        PasswordAuthentication = lib.mkDefault false;
        KbdInteractiveAuthentication = lib.mkDefault false;
      };
    };
  };
}
