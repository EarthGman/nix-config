{
  config,
  pkgs,
  lib,
  hostname,
  ...
}:
let
  signingkey = config.gman.ssh-keys.g;
  extraHM = ../../hosts/${hostname}/users/g/home-manager.nix;
in
{
  imports = lib.optionals (builtins.pathExists extraHM) [
    extraHM
  ];

  config = lib.mkMerge [
    {
      gman = {
        lh-mouse.enable = lib.mkOverride 800 true;
        nix-development.enable = lib.mkDefault true;
        neomutt.enable = lib.mkDefault true;
      };

      meta = {
        profiles.firefox = "shyfox";
        editor = "nvim";
        browser = "firefox";
        fileManager = "nautilus";
      };

      programs = {
        git = {
          userName = "EarthGman";
          userEmail = "EarthGman@protonmail.com";
          signing = {
            key = signingkey;
            signByDefault = true;
            signer = "";
          };
          extraConfig = {
            gpg.format = "ssh";
            gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
            init.defaultBranch = "main";
          };
        };
        zsh = {
          shellAliases = {
            edit-config = "cd ~/src/github/earthgman/nix-config && $EDITOR .";
          };
          initContent = ''
            export MANPAGER='nvim +Man!'
          '';
        };

        # use customized neovim
        neovim-custom = {
          enable = true;
          viAlias = true;
          vimAlias = true;
        };
      };

      programs.ssh = {
        enable = true;
        forwardAgent = true;
        extraConfig = "IdentityAgent ${config.home.homeDirectory}/.1password/agent.sock";
      };

      wayland.windowManager.hyprland.settings = {
        animations.enabled = false;
      };
    }

    # desktop only
    (lib.mkIf (config.meta.desktop != "") {
      programs = {
        obsidian.enable = lib.mkDefault true;
        freetube.enable = lib.mkDefault true;
        moonlight.enable = lib.mkDefault true;
        discord.enable = lib.mkDefault true;
        protonmail-desktop.enable = lib.mkDefault true;
      };
    })
  ];
}
