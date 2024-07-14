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
  networking = {
    hostName = "nixos";
    firewall.allowedTCPPorts = [ 22 ];
  };
  users.mutableUsers = false;

  users.users."nixos" = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [ "wheel" ];
    hashedPassword = null; # is set to "" by default causing a confliction with password
    password = "123"; # required for ssh during installation
    shell = pkgs.zsh;
  };

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
