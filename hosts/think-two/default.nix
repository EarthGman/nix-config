{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
    ./hardware-configuration.nix
  ];

  nix.settings.trusted-users = [ "Chris" ];

  gman = {
    openvpn.enable = true;
  };

  programs = {
    libreoffice.enable = true;
    thunderbird.enable = true;

    neovim-custom = {
      enable = true;
      package = pkgs.gman.nvim-nix;
    };
  };

  services.openssh.settings = {
    PasswordAuthentication = true;
    KbdInteractiveAuthentication = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  boot.loader.grub.extraEntries = lib.mkForce ''
    menuentry 'Windows 11' --class windows --class os {
      insmod part_gpt
      insmod ntfs
      search --no-floppy --fs-uuid --set=root 2727-C821
      chainloader /efi/Microsoft/Boot/bootmgfw.efi
    }
    menuentry 'UEFI Firmware Setup' --id 'uefi-firmware' {
      fwsetup
    } 
    menuentry "Reboot" {
      reboot
    }
    menuentry "Poweroff" {
      halt
    } 
  '';
}
