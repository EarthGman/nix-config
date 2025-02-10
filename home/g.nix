{ self, outputs, config, pkgs, lib, hostName, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  signingkey = outputs.keys.g_pub;
  LHmouse = builtins.toFile "lh-mouse.xmodmap" "pointer = 3 2 1";
in
{
  imports = [
    (self + /hosts/${hostName}/users/g/preferences.nix)
    (outputs.homeProfiles.essentials)
  ];

  custom = {
    fileManager = "yazi";
  };

  programs = {
    git = {
      userName = "EarthGman";
      userEmail = "EarthGman@protonmail.com";
      signing = {
        key = signingkey;
        signByDefault = true;
        gpgPath = "";
      };
      extraConfig = {
        gpg.format = "ssh";
        gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
        init.defaultBranch = "main";
      };
    };
    zsh = {
      shellAliases = {
        edit-config = "cd ~/src/nix-config && $EDITOR .";
      };
      initExtra = ''
        export MANPAGER='nvim +Man!'
      '';
    };

    ardour = enabled;
    bottles = enabled;
    freetube = enabled;
    filezilla = enabled;
    gcolor = enabled;
    ghex = enabled;
    museeks = enabled;
    nautilus.enable = true;
    prismlauncher = enabled;
    discord = enabled;

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
      input.left_handed = true;
      # bind = [
      #   "Alt, Space, exec, rofi -show window"
      # ];
    };
  };
}
