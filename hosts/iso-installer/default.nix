{ pkgs, lib, modulesPath, platform, ... }:
{
  boot = {
    kernelPackages = lib.mkOverride 0 pkgs.linuxPackages_latest;
    supportedFilesystems = [ "bcachefs" "ext4" "vfat" ];
  };
  environment.systemPackages = with pkgs; [
    _1password
    bcachefs-tools
    cryptsetup
    keyutils
    git
    disko
    gparted
    wget
    file
    sops
    age
    ripgrep
    zip
    unzip
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  nixpkgs.hostPlatform = platform;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
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
