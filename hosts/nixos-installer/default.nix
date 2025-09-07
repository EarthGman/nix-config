# Gman's custom installer ISO
{
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  gman = {
    debloat.enable = true;
    hardware-tools.enable = true;
  };

  # needed for some machines
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  hardware = {
    enableRedistributableFirmware = true;

    # no need for these on an installer
    cpu.intel.updateMicrocode = false;
    cpu.amd.updateMicrocode = false;
  };

  users.users.root = {
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      config.gman.ssh-keys.g
    ];
  };

  time.timeZone = "America/Chicago";

  boot = {
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

  programs = {
    neovim-custom = {
      enable = true;
      defaultEditor = true;
      # custom build of neovim with only nix lsp
      package = pkgs.nvim-nix;
    };

    zsh = {
      # cannot use the standard method of vi and vim aliases
      # vi and vim packages must be uninstalled, however someone at nixpkgs
      # decided to put vim into environment.systemPackages instead of using programs.vim.enable
      # https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/profiles/base.nix
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
