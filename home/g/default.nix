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
  imports =
    lib.optionals (builtins.pathExists extraHM) [
      extraHM
    ]
    ++ [ ./identity.nix ];

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
        zsh = {
          shellAliases = {
            edit-config = "cd ~/src/github/earthgman/nix-config && $EDITOR .";
          };
          initContent = ''
            export MANPAGER='nvim +Man!'
          '';
        };
        ssh = {
          enable = true;
          matchBlocks."*" = {
            forwardAgent = true;
          };
          # extraConfig = "IdentityAgent ${config.home.homeDirectory}/.1password/agent.sock";
        };

        # use customized neovim
        neovim-custom = {
          enable = true;
          viAlias = true;
          vimAlias = true;
        };
      };

      services.protonmail-bridge.enable = true;

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
        # protonmail-desktop.enable = lib.mkDefault true;
      };
    })
  ];
}
