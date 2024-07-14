{ pkgs, lib, ... }:
{
  boot = {
    kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_latest;

    # disables zfs
    supportedFilesystems = lib.mkForce [
      "auto"
      "bcachefs"
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
  networking.firewall.allowedTCPPorts = [ 22 ];
  users.mutableUsers = true;

  nixpkgs.overlays = [
    (self: super: {
      haskellPackages = super.haskellPackages.override {
        overrides = self: super: {
          # Disable tests for all Haskell packages
          mkDerivation = args: super.mkDerivation (args // {
            doCheck = false;
          });
        };
      };
    })
  ];
}
