{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.personal-profile;
in
{
  options.gman.personal-profile = {
    enable = lib.mkEnableOption "gman's personal profile";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        gman = {
          kanata.enable = lib.mkDefault true;
          syncthing.enable = lib.mkDefault true;
          nix-development.enable = lib.mkDefault true;
          security-hardening.enable = lib.mkDefault true;
        };

        environment.systemPackages = [
          pkgs.man-pages-posix
        ];

        # allow decrypting of gpg key on login
        security.pam.services.login.gnupg = {
          enable = lib.mkDefault true;
          storeOnly = lib.mkDefault true;
        };

        # allow nixos rebuiling over ssh
        nix.settings.trusted-users = [ "g" ];

        programs = {
          neovim-custom = {
            enable = true;
            package = lib.mkDefault pkgs.nvim;
            viAlias = true;
            vimAlias = true;
            defaultEditor = true;
          };
          gh.enable = true;
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
          calcure.enable = lib.mkDefault true;
          rofi.enable = lib.mkDefault true;
          kitty.enable = lib.mkDefault true;
          rmpc.enable = lib.mkDefault true;
          freetube.enable = lib.mkDefault true;
          qutebrowser.enable = lib.mkDefault true;
          vlc.enable = lib.mkDefault true;
          discord.enable = lib.mkDefault true;
          neomutt.enable = lib.mkDefault true;
        };
      })
      (lib.mkIf (config.meta.server) {
        programs.neovim-custom.package = pkgs.nvim-lite;
        gman.nix-development.enable = lib.mkOverride 899 false;
      })
    ]
  );
}
