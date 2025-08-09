{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.personalized-modules.earthgman;
in
{
  imports = lib.autoImport ./.;

  options.gman.personalized-modules.earthgman = {
    enable = lib.mkEnableOption "gman's more heavily personalized modules";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        gman = {
          personalized-modules.earthgman = {
            kanata.enable = lib.mkDefault true;
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

        # disable stock vims
        programs.neovim.enable = lib.mkForce false;
        programs.vim.enable = lib.mkForce false;

        programs.neovim-custom = {
          enable = true;
          package = lib.mkDefault pkgs.nvim;
          viAlias = true;
          vimAlias = true;
          defaultEditor = true;
        };
      }
      # server only
      (lib.mkIf config.meta.server {
        programs.neovim-custom.package = pkgs.nvim-lite;
      })

      # desktop only
      (lib.mkIf (config.meta.desktop != "") {
        gman = {
          android.enable = true;
          onepassword.enable = true;
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
