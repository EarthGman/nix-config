{
  self,
  keys,
  config,
  pkgs,
  lib,
  hostName,
  ...
}:
let
  inherit (lib) mkDefault;
  enabled = {
    enable = mkDefault true;
  };
  signingkey = keys.g_ssh_pub;
  LHmouse = builtins.toFile "lh-mouse.xmodmap" "pointer = 3 2 1";
  extraHM = (self + "/hosts/${hostName}/users/g/preferences.nix");
in
{
  imports = lib.optionals (builtins.pathExists extraHM) [
    extraHM
  ];

  profiles = {
    essentials.enable = mkDefault true;
  };

  custom = {
    profiles.firefox = "shyfox";
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
    neovim-custom = {
      viAlias = true;
      vimAlias = true;
    };
    rmpc = enabled;
    bottles = enabled;
    freetube = enabled;
    filezilla = enabled;
    gcolor = enabled;
    ghex = enabled;
    moonlight = enabled;
    discord = enabled;

    mov-cli = {
      enable = mkDefault true;
      plugins = [ pkgs.mov-cli-youtube ];
    };

    # fun and useless
    pipes = enabled;
    cbonsai = enabled;
    cmatrix = enabled;
    cava = enabled;
    sl = enabled;
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = "IdentityAgent ${config.home.homeDirectory}/.1password/agent.sock";
  };

  xsession.windowManager.i3.config.startup = [
    {
      command = "${lib.getExe pkgs.xorg.xmodmap} ${LHmouse}";
      always = true;
      notification = false;
    }
  ];
  wayland.windowManager = {
    sway.config.input = {
      "type:pointer" = {
        left_handed = "enabled";
      };
    };
    hyprland.settings = {
      animations.enabled = false;
      input.left_handed = true;
    };
  };
}
