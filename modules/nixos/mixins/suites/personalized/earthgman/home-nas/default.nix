{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.suites.personalized.earthgman.home-nas.enable =
    lib.mkEnableOption "gman's home-nas client configuration";

  config = lib.mkIf config.gman.suites.personalized.earthgman.home-nas.enable {
    environment.systemPackages = [
      pkgs.cifs-utils
    ];

    sops.secrets.home_nas_smb_secrets = {
      sopsFile = ../../../../../../../secrets/shared.yaml;
      path = "/etc/samba/secrets";
    };

    fileSystems."/home/g/nas" = {
      device = "//home-nas/private";
      fsType = "cifs";
      options =
        let
          automount-opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,";
        in
        [ "${automount-opts},credentials=/etc/samba/secrets,uid=1000,gid=100" ];
    };

    # workaround systemd automount breaking everything if the PC is disconnected from the internet
    networking.networkmanager.dispatcherScripts = [
      {
        source = pkgs.writeText "home-nas-mount-manager" ''
          i=0
          while [ $i -lt 3 ]; do
            ${pkgs.iputils}/bin/ping -c 1 -W 3 home-nas
            if [ $? == "0" ]; then
              if [[ $(systemctl status home-g-nas.automount | grep inactive) ]]; then
                systemctl restart home-g-nas.automount
              fi
              exit 0
            fi
            ((i++))
          done

          echo "could not reach NAS server after 3 tries"
          systemctl stop home-g-nas.automount
        '';
      }
    ];
  };
}
