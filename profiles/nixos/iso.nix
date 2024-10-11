{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    disko
  ];
  users.users.nixos = {
    # for SSH
    initialHashedPassword = lib.mkForce "$y$j9T$d2RB4sobsNvCRKTiZL04K1$oHhfOT2x9Ie4.eDXb9x8SN2EeuNqXSyNBcddA/xWlD3";
  };

  hardware.enableRedistributableFirmware = lib.mkForce false;

  boot = {
    # always use latest linux kernel
    kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_latest;

    # disables zfs, bcachefs
    #TODO figure out how to use zfs
    supportedFilesystems = lib.mkForce [
      "auto"
      #"bcachefs"
      "btrfs"
      "cifs"
      "ext4"
      "f2fs"
      "jfs"
      "ntfs"
      "overlay"
      "reiserfs"
      "squashfs"
      "tmpfs"
      "vfat"
      "xfs"
      # "zfs"
    ];
  };
}

