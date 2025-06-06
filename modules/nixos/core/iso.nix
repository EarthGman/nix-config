# Warning: installerprofile from nixpkgs depends on an iso special argument to import
{ inputs, pkgs, lib, config, modulesPath, ... }@args:
let
  iso = if args ? iso then args.iso else false;
  desktop = if args ? desktop then args.desktop else null;
  system = if args ? system then args.system else "x86_64-linux";
  inherit (lib) mkEnableOption mkIf;
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
    programs.neovim-custom.package = inputs.vim-config.packages.${system}.nvim-lite;
    users.users.root = {
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

