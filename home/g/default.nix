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
        qutebrowser.enable = lib.mkDefault true;
      };

      meta = {
        profiles.firefox = "shyfox";
        editor = "nvim";
        browser = "qutebrowser";
        fileManager = "yazi";
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
      services = {
        kdeconnect = {
          enable = lib.mkDefault true;
          indicator = lib.mkDefault true;
        };
      };

      programs = {
        obsidian.enable = lib.mkDefault true;
        qutebrowser.enable = lib.mkForce true;
        freetube = {
          enable = lib.mkDefault true;
          package = pkgs.freetube.overrideAttrs (a: rec {
            version = "0.23.11";

            src = pkgs.fetchFromGitHub {
              owner = "FreeTubeApp";
              repo = "Freetube";
              rev = "382cfeb7cb109e44e81075cbe87c622114e7d0ff";
              hash = "sha256-AmT0zNqFJEG1qjMBgMTUKmEsZrJqocxRzPkTl25HiUs=";
            };

            yarnOfflineCache = pkgs.fetchYarnDeps {
              yarnLock = "${src}/yarn.lock";
              hash = "sha256-sM9CkDnATSEUf/uuUyT4JuRmjzwa1WzIyNYEw69MPtU=";
            };
          });
        };
        moonlight.enable = lib.mkDefault true;
        discord.enable = lib.mkDefault true;
        # protonmail-desktop.enable = lib.mkDefault true;
      };
    })
  ];
}
