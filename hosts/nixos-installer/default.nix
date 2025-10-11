# Gman's custom installer ISO
{
  pkgs,
  lib,
  config,
  modulesPath,
  inputs,
  ...
}:
let
  install-sh = pkgs.writeShellScriptBin "install.sh" (builtins.readFile ./install.sh);
in
{
  imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];

  gman = {
    debloat.enable = true;
    hardware-tools.enable = true;
  };

  hardware = {
    # needed for some machines
    enableRedistributableFirmware = true;

    # no need for these on an installer
    cpu.intel.updateMicrocode = false;
    cpu.amd.updateMicrocode = false;
  };

  services.getty.helpLine = lib.mkForce ''
    Welcome to EarthGman's NixOS installer.

    To log in over ssh, set a password for the root user with `sudo passwd`

    Begin install by running `install.sh` as root.
  '';

  environment = {
    systemPackages = [
      # latest disko
      inputs.disko.packages.${config.meta.system}.disko

      install-sh
      pkgs.nixfmt
      pkgs.sops
      pkgs.age
    ];

    # these are not set properly on nixos by default
    sessionVariables = {
      SYSTEMD_KEYMAP_DIRECTORIES = "${pkgs.kbd}/share/keymaps";
    };

    #	make all possible locales accessible for install script
    etc = {
      "locales.txt".source = ./locales.txt;
    };
  };

  # zsh will complain about no config file in the home directory
  users.users.nixos.shell = pkgs.bash;

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
