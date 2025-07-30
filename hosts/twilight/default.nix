{ inputs, ... }:
{
  imports = [
    ./disko.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
  ];

  profiles = {
    gman = {
      enable = true;
      wireguard.wg1.enable = true;
    };
  };

  modules = {
    steam.enable = true;
    flatpak.enable = true;
  };

  programs = {
    # lens.enable = true;
    fastfetch.enable = true;
    prismlauncher.enable = true;
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
}
