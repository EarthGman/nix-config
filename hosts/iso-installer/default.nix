{ pkgs, lib, modulesPath, outputs, ... }:
{
  boot = {
    kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_latest;
    supportedFilesystems = [
      "btrfs"
      "bcachefs"
      "ext4"
      "vfat"
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
    # Prevent mbrola-voices (~650MB) from being on the live media
    (_final: super: {
      espeak = super.espeak.override {
        mbrolaSupport = false;
      };
    })
    # Makes `availableOn` fail for zfs, see <nixos/modules/profiles/base.nix>.
    # This is a workaround since we cannot remove the `"zfs"` string from `supportedFilesystems`.
    # The proper fix would be to make `supportedFilesystems` an attrset with true/false which we
    # could then `lib.mkForce false`
    # - https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-minimal-new-kernel-no-zfs.nix
    (_final: super: {
      zfs = super.zfs.overrideAttrs (_: {
        meta.platforms = [ ];
      });
    })
  ];
}
