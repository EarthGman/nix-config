# modules consumed by both nixos and home-manager configurations
{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  # detect gpu type using config.meta on nixos and propagate the btop package to home-manager
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  gpu =
    if (config.meta ? gpu) then
      config.meta.gpu
    else if (nixosConfig != null) then
      nixosConfig.meta.gpu
    else
      null;
in
{
  imports = lib.autoImport ./.;

  config = lib.mkIf config.gman.enable {
    nixpkgs = {
      config.allowUnfree = lib.mkDefault true;
    };

    meta.profiles = {
      stylix = lib.mkDefault "ashes";
    };

    gman = {
      tmux.enable = true;
    };

    # stuff im sure everyone wants
    programs = {
      ncdu.enable = lib.mkDefault true;
      hstr.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;
      fd.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      btop = {
        enable = lib.mkDefault true;
        package =
          if (gpu == "amd") then
            pkgs.btop-rocm
          else if (gpu == "nvidia") then
            pkgs.btop-cuda
          else
            pkgs.btop;
      };
      sysz.enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      lazygit.enable = lib.mkDefault true;
      ripgrep.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
      bat.enable = lib.mkDefault true;
      starship.enable = lib.mkDefault true;
      tmux.enable = lib.mkDefault true;
    };
  };
}
