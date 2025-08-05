{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkForce;
in
{
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

  services.openssh = {
    settings.PasswordAuthentication = true;
  };
  # debloat
  documentation.enable = false;
}
