# personalized wrapper of modules and options for my PCs
{
  pkgs,
  lib,
  config,
  keys,
  ...
}@args:
let
  inherit (lib)
    mkIf
    mkEnableOption
    autoImport
    mkDefault
    mkMerge
    ;
  cfg = config.profiles.gman;

  desktop = if args ? desktop then args.desktop else null;
in
{
  imports = autoImport ./.;

  options.profiles.gman.enable = mkEnableOption "my personal configuration modules";
  config = mkIf cfg.enable (mkMerge [
    {
      users.users.root.openssh.authorizedKeys.keys = [ keys.g_ssh_pub ];
      time.timeZone = "America/Chicago";
      services = {
        # ensure that password ssh authentication is disabled
        openssh.settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };
      profiles.gman = {
        kanata-keymap.enable = mkDefault true;
        wireguard.wg0.enable = mkDefault true;
      };

      # allow nixos rebuiling over ssh
      nix.settings.trusted-users = [ "g" ];
    }
    (mkIf (desktop != null) {
      # some extra man pages
      documentation.dev.enable = true;
      environment.systemPackages = with pkgs; [
        man-pages
        man-pages-posix
      ];
      modules = {
        android.enable = true;
        zsa-keyboard.enable = true;
        onepassword.enable = true;
      };
      services = {
        libinput.mouse.leftHanded = true;
      };
      profiles = {
        hacker-mode.enable = mkDefault true;
        nix-tools.enable = mkDefault true;
      };
    })
  ]);
}
