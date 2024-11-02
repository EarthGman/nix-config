{ config, pkgs, lib, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
  LHmouse = builtins.toFile "lh-mouse.xmodmap" "pointer = 3 2 1";
in
{
  custom = {
    editor = "codium";
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
      };
    };

    audacity = enabled;
    ardour = enabled;
    autokey = enabled;
    bottles = enabled;
    clipgrab = enabled;
    firefox = enabled;
    freetube = enabled;
    gnome-calculator = enabled;
    gnome-system-monitor = enabled;
    gthumb = enabled;
    gimp = enabled;
    gcolor = enabled;
    musescore = enabled;
    # openshot = enabled; borked atm
    video-trimmer = enabled;
    nautilus = enabled;
    fastfetch = enabled;
    evince = enabled;
    vlc = enabled;
    libreoffice = enabled;
    museeks = enabled;
    obsidian = enabled;
    prismlauncher = enabled;
    pwvucontrol = enabled;
    thunderbird = enabled;
    switcheroo = enabled;
    discord = enabled;
    xclicker = enabled;
    yazi = enabled;

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
