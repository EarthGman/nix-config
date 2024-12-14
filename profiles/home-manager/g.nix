{ self, outputs, config, pkgs, lib, hostName, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  signingkey = outputs.keys.g_pub;
  LHmouse = builtins.toFile "lh-mouse.xmodmap" "pointer = 3 2 1";
in
{
  imports = [
    (self + /hosts/${hostName}/users/g/preferences.nix)
    ./essentials.nix
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
    zsh.shellAliases = {
      edit-config = "cd ~/src/nix-config && $EDITOR .";
    };

    ardour = enabled;
    autokey = enabled;
    bottles = enabled;
    freetube = enabled;
    filezilla = enabled;
    gcolor = enabled;
    gscan2pdf = enabled;
    musescore = enabled;
    museeks = enabled;
    mov-cli = enabled;
    nautilus.enable = true;
    sparrow = enabled;
    prismlauncher = enabled;
    discord = enabled;
    xclicker = enabled;

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
  wayland.windowManager.hyprland.settings.input.left_handed = true;
}
