{ inputs, outputs, pkgs, lib, config, system, stateVersion, ... }:
let
  inherit (lib) mkDefault;
in
{
  users.users."root" = {
    openssh.authorizedKeys.keys = mkDefault [ outputs.keys.g_pub ];
    shell = pkgs.zsh;
  };

  time.timeZone = mkDefault "America/Chicago";
  nixpkgs.config.allowUnfree = true;
  system = {
    inherit stateVersion;
  };

  programs = {
    neovim-custom = {
      enable = mkDefault true;
      package = mkDefault inputs.vim-config.packages.${system}.nvim-lite;
      viAlias = true;
      vimAlias = true;
    };
    zsh.enable = true;
    yazi.enable = mkDefault true;
    starship.enable = mkDefault true;
    bat.enable = mkDefault true;
    zoxide = {
      enable = mkDefault true;
      flags = mkDefault [ "--cmd j" ];
    };
  };

  environment.systemPackages = with pkgs; [
    sysz
    hstr
    fd
    btop
    ncdu
    zip
    unzip
    lsof
  ];
}
