{ inputs, ... }:
{
  imports = [
    ./disko.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
  ];

  profiles = {
    # wg1.enable = true;
    gman-pc.enable = true;
  };

  programs.fastfetch.enable = true;

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
    /run/current-system/sw/bin/modprobe  -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
  ";

  modules = {
    steam.enable = true;
  };

  zramSwap.enable = true;
}
