{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.earthgman;
in
{
  options.gman.earthgman = {
    enable = lib.mkEnableOption "gman's more heavily personalized modules";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        gman = {
          kanata.enable = lib.mkDefault true;
        };

        security.pam.services.login.gnupg = {
          enable = lib.mkDefault true;
          storeOnly = lib.mkDefault true;
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
        };

        services.libinput = {
          touchpad.leftHanded = true;
          mouse.leftHanded = true;
        };
        hardware.keyboard.zsa.enable = lib.mkDefault true;
        programs = {
          keymapp.enable = lib.mkDefault true;
        };
      })
      (lib.mkIf (config.meta.server) {
        programs.neovim-custom.package = pkgs.nvim-lite;
      })
    ]
  );
}
