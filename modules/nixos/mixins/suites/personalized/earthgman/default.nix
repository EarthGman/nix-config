{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.suites.personalized.earthgman;
in
{
  imports = lib.autoImport ./.;

  options.gman.suites.personalized.earthgman = {
    enable = lib.mkEnableOption "gman's more heavily personalized modules";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        gman.suites = {
          personalized.earthgman = {
            kanata.enable = lib.mkDefault true;
            wireguard.wg0.enable = lib.mkDefault true;
          };
        };

        services = {
          # ensure that password ssh authentication is disabled
          openssh.settings = {
            PasswordAuthentication = lib.mkDefault false;
            KbdInteractiveAuthentication = lib.mkDefault false;
          };
        };

        # allow nixos rebuiling over ssh
        nix.settings.trusted-users = [ "g" ];

        programs.neovim-custom = {
          enable = true;
          package = lib.mkDefault pkgs.nvim;
          viAlias = true;
          vimAlias = true;
          defaultEditor = true;
        };
      }

      # desktop only
      (lib.mkIf (config.meta.desktop != "") {
        gman = {
          android.enable = lib.mkDefault true;
          onepassword.enable = lib.mkDefault true;
        };

        services.libinput.mouse.leftHanded = true;
        hardware.keyboard.zsa.enable = lib.mkDefault true;
        programs = {
          keymapp.enable = lib.mkDefault true;
          _1password-gui.polkitPolicyOwners = [ "g" ];
        };
      })
    ]
  );
}
