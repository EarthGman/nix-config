{ outputs, pkgs, lib, ... }:
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

  users.users."root" = {
    initialHashedPassword = lib.mkForce "$y$j9T$d2RB4sobsNvCRKTiZL04K1$oHhfOT2x9Ie4.eDXb9x8SN2EeuNqXSyNBcddA/xWlD3";
  };

  nixpkgs.overlays = [
    outputs.overlays.disable-mbrola-voices
  ] ++ [
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
