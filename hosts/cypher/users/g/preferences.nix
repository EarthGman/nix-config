{ pkgs, self, config, wallpapers, ... }:
let
  template = self + /templates/home-manager;
  signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
in
{
  imports = [
    template
  ];

  stylix.image = builtins.fetchurl wallpapers.kaori;
  stylix.colorScheme = "april";

  custom = {
    firefox.theme.name = "shyfox";
    firefox.theme.config.wallpaper = builtins.fetchurl wallpapers.april-night;

    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;
    musescore.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";

    ygo-omega.enable = true;
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
