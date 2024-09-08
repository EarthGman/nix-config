{ pkgs, lib, config, ... }:
let
  enabled = { enable = lib.mkDefault true; };
  signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
in
{
  custom = {
    preferredEditor = lib.mkDefault "codium";
    bottles = enabled;
    clipgrab = enabled;
    zsh = enabled;
    firefox = enabled;
    gnome-calculator = enabled;
    gnome-system-monitor = enabled;
    gthumb = enabled;
    gimp = enabled;
    gcolor = enabled;
    musescore = enabled;
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
    discord = enabled;
    xclicker = enabled;
    yazi = enabled;

    # fun and useless
    pipes = enabled;
    cbonsai = enabled;
    cmatrix = enabled;
  };

  programs.ssh = {
    enable = true;
    forwardAgent = true;
    extraConfig = "${config.home.homeDirectory}/.1password/agent.sock";
  };

  programs.git = {
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
}
