{
  pkgs,
  lib,
  config,
  modulesPath,
  ...
}@args:
let
  inherit (lib) mkEnableOption mkIf mkForce;
  iso = if args ? iso then args.iso else false;
  desktop = if args ? desktop then args.desktop else null;
  cfg = config.modules.iso;
  installerProfile =
    if iso then
      if desktop == null then
        [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ]
      else
        [ (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares.nix") ]
    else
      [ ];
in
{
  imports = installerProfile;
  options.modules.iso.enable = mkEnableOption "installer module";
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      disko
    ];

    programs.neovim-custom.package = pkgs.nvim-nix;
    # Temporary solution until I can figure what to do about the issue with importing the cd-minimal.nix profile from nixpkgs
    # basically some guy decided to place pkgs.vim into environment.systemPackages instead of using programs.vim.enable
    # https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/profiles/base.nix
    programs.zsh = {
      shellAliases =
        let
          cfg = config.programs.neovim-custom;
        in
        {
          vi = mkIf cfg.viAlias ("nvim");
          vim = mkIf cfg.vimAlias ("nvim");
        };
    };

    users.users.root = {
      shell = mkForce pkgs.zsh;
      # for SSH
      password = "123";
      hashedPassword = null;
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
      settings.PasswordAuthentication = true;
    };
    # debloat
    documentation.enable = false;
  };
}
