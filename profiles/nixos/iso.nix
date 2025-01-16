{ pkgs, lib, config, ... }:
{
  environment.systemPackages = with pkgs; [
    disko
  ];
  users.users.nixos = {
    # for SSH
    password = "123";
  };

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

  services.openssh = {
    passwordAuthentication = true;
  };
  # debloat
  documentation.enable = false;
}

