{ pkgs, inputs, ... }:
{
  imports = [
    ./disko.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
  ];

  time.timeZone = "America/Chicago";

  gman = {
    steam.enable = true;
    wireguard.main.enable = true;
    wireguard.homelab.enable = true;
    hacker-mode.enable = true;
    earthgman.enable = true;
  };

  services = {
    xserver.xkb.layout = "jp";

    # used for mw -t
    cron = {
      enable = true;
    };
  };

  security.pam.services.login.gnupg = {
    enable = true;
    storeOnly = true;
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
    simple-scan.enable = true;
    gimp.enable = true;
    libreoffice.enable = true;
    filezilla.enable = true;
    moonlight.enable = true;
    gnome-software.enable = true;
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

  services.displayManager.sddm.themeConfig = {
    FullBlur = "false";
    PartialBlur = "false";
  };

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
