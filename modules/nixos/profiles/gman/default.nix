# personalized wrapper of modules and options for my PCs
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib)
    mkIf
    mkEnableOption
    autoImport
    mkDefault
    ;
  cfg = config.profiles.gman;
in
{
  imports = autoImport ./.;

  options.profiles.gman.enable = mkEnableOption "my personal configuration modules";
  config = mkIf cfg.enable {
    profiles = {
      hacker-mode.enable = mkDefault true;
      nix-tools.enable = mkDefault true;
      gman = {
        kanata-keymap.enable = mkDefault true;
        wireguard.wg0.enable = mkDefault true;
      };
    };

    modules = {
      android.enable = true;
      zsa-keyboard.enable = true;
      onepassword.enable = true;
    };

    services = {
      libinput.mouse.leftHanded = true;
      openssh.settings.PasswordAuthentication = false;
    };

    programs = {
      xclicker.enable = true;
    };

    nix.settings.trusted-users = [ "g" ];
    # some extra man pages
    documentation.dev.enable = true;
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];
  };
}
