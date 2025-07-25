# personalized wrapper of modules and options for my PCs
{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption mkDefault;
  cfg = config.profiles.gman-pc;
in
{
  options.profiles.gman-pc.enable = mkEnableOption "my custom pc module";
  config = mkIf cfg.enable {
    profiles = {
      gmans-keymap.enable = true;
      hacker-mode.enable = mkDefault true;
      wg0.enable = mkDefault true;
      nix-tools.enable = mkDefault true;
    };

    modules = {
      android.enable = true;
      zsa-keyboard.enable = true;
      onepassword.enable = true;
      ledger.enable = true;
    };

    services = {
      libinput.mouse.leftHanded = true;
      openssh.settings.PasswordAuthentication = false;
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
