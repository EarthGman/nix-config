{ inputs, pkgs, lib, config, username, ... }:
let
  inherit (lib) mkDefault mkIf;
in
{
  # imports = [
  #   inputs.stylix.nixosModules.stylix
  # ];
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    excludePackages = with pkgs; [ xterm ];
  };
  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal ];
    extraPortals = [ pkgs.xdg-desktop-portal ];
  };
  custom = {
    sound.enable = mkDefault true;
    printing.enable = mkDefault true;
    ifuse.enable = mkDefault true;
    grub.enable = mkDefault true;
  };
  # decorate shell for root ~2.5GB of bloat
  programs = {
    zsh = {
      enableCompletion = mkDefault true;
      syntaxHighlighting.enable = mkDefault true;
    };
    starship.enable = mkDefault true;
  };

  # if you have dolphin emu installed GC controllers will not have correct permissions unless set
  # services.udev.packages = mkIf config.home-manager.users.${username}.custom.dolphin-emu.enable [ pkgs.dolphinEmu ];
}
