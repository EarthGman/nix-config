{ outputs, pkgs, lib, displayManager, ... }:
{
  imports = [ ./fs.nix ] ++ lib.optionals (displayManager == "sddm") [ ./sddm.nix ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "ahci"
    "xhci_pci"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelParams = [
    "amd_iommu=on"
  ];

  boot.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=1002:164e,1002:1640
    softdep amdgpu pre: vfio-pci
  '';

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  networking = {
    # required for sins of a solar empire lag bug in multiplayer
    extraHosts = ''66.79.209.80 ico-reb.stardock.com'';
  };
  services.zerotierone = {
    enable = true;

    joinNetworks = [
      # personal darkweb
      "d5e5fb653723b80e"
    ];
  };

  boot.loader.grub.themeConfig = {
    background = outputs.wallpapers.april-red;
  };

  # hardware.graphics = {
  #   extraPackages = with pkgs; [
  #     # for davinci resolve 6GB of bloat tho
  #     rocm-opencl-icd
  #     rocm-opencl-runtime
  #   ];
  # };

  custom = {
    steam.enable = true;
    onepassword.enable = true;
    sunshine.enable = true;
    virtualization.enable = true;
  };

  services.displayManager.defaultSession = "none+i3";
}
