{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./disko.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
  ];

  time.timeZone = "America/Chicago";

  gman = {
    steam.enable = true;
    wireguard.main.enable = true;
    hacker-mode.enable = true;
    personal-profile.enable = true;
    postgresql.enable = true;
    libvirtd.enable = true;
    # profiles.sddm.astronaut.config.embeddedTheme = "hyprland_kath";
  };

  sops.secrets.pgadmin_pass.path = "/var/lib/sops-nix/pgadmin-pass";

  services = {
    xserver.xkb.layout = "jp";

    pgadmin = {
      enable = true;
      initialEmail = "EarthGman@protonmail.com";
      initialPasswordFile = config.sops.secrets.pgadmin_pass.path;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [
      22000
      21027
    ];
  };

  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = [ pkgs.fcitx5-mozc ];
    };
    extraLocales = [
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  programs = {
    # lens.enable = true;
    audacity.enable = true;
    ardour.enable = true;
    bustle.enable = true;
    simple-scan.enable = true;
    gimp.enable = true;
    gcolor.enable = true;
    libreoffice.enable = true;
    filezilla.enable = true;
    moonlight.enable = true;
    puddletag.enable = true;
    fastfetch.enable = true;
    prismlauncher.enable = true;
    ani-cli.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];

  boot.kernelParams = [ "video=1366x768" ];

  # bad intel
  boot.extraModprobeConfig = ''
    blacklist mei_me
  '';

  boot.loader.grub.gfxmodeBios = "1366x768";

  services.thinkfan.enable = true;

  # https://discourse.nixos.org/t/thinkfan-not-working-in-nixos/8260
  systemd.services.thinkfan.preStart = "
    /run/current-system/sw/bin/modprobe -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
  ";

  environment.etc = {
    "ssh/ssh_host_ed25519_key.pub".source = ./ssh_host_ed25519_key.pub;
    "ssh/ssh_host_rsa_key.pub".source = ./ssh_host_rsa_key.pub;
  };

  sops.secrets = {
    ssh_host_ed25519_key.path = "/etc/ssh/ssh_host_ed25519_key";
    ssh_host_rsa_key.path = "/etc/ssh/ssh_host_rsa_key";
  };
}
