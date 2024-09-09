# UEFI, Q35, Qemu proxmox virtual machine
{
  imports = [
    ./disko.nix
  ];
  # use systemd boot, might use UKI later?
  boot = {
    initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" ];
    kernelParams = [ "quiet" "noatime" ];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # security hole #TODO use ssh keys instead of root pass
  users.users."root".hashedPassword = "$y$j9T$b31VCG47P7qQhhu26ILtZ1$FuXzVVrEaqegBiczyNN8NlWSYSkYo4t7D/.jBxA6ur/";
}
