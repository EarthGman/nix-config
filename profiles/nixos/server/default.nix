# UEFI, Q35, Qemu proxmox virtual machine
{ pkgs, ... }:
let
  ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
in
{
  imports = [
    ./disko.nix
  ];
  # debloat
  hardware.enableRedistributableFirmware = false;
  # use systemd boot, might use UKI later?
  modules.bootloaders.systemd-boot.enable = true;
  boot = {
    kernelParams = [ "quiet" "noatime" ];
    tmp.cleanOnBoot = true;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # join zerotier network
  services.zerotierone = {
    enable = true;
    joinNetworks = [
      "d5e5fb653723b80e"
    ];
  };

  # admin
  users.users.g = {
    hashedPassword = "$y$j9T$za3lM.azPMASkrasWaw1M/$mkRlFSsS1gZUb2rBEtGRMGK9v.9MRFMdokJh292H2LA";
    password = null;
    isNormalUser = true;
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ ssh-key ];
    extraGroups = [
      "wheel"
    ];
  };
}
