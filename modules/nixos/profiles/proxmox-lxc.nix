{ inputs, outputs, config, pkgs, lib, system, stateVersion, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
  cfg = config.profiles.proxmox-lxc;
in
{
  options.profiles.proxmox-lxc.enable = mkEnableOption "proxmox-lxc profile";
  config = mkIf cfg.enable {
    users.users."root" = {
      openssh.authorizedKeys.keys = mkDefault [ outputs.keys.g_pub ];
    };

    time.timeZone = mkDefault "America/Chicago";

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    nixpkgs.config.allowUnfree = true;

    system = {
      inherit stateVersion;
    };

    programs = {
      neovim-custom = {
        package = mkDefault inputs.vim-config.packages.${system}.nvim-lite;
      };
    };
  };
}
