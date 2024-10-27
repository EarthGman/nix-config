{ pkgs, self, lib, ... }:
let
  inherit (lib) mkForce;
  profile = self + /profiles/home-manager/g.nix;
  theme = self + /profiles/home-manager/desktop-themes/faraway.nix;
in
{
  imports = [
    profile
    theme
  ];

  programs = {
    dolphin-emu.enable = true;
    lutris.enable = true;
    davinci-resolve.enable = true;

    looking-glass.enable = true;
    looking-glass.version = "B6";
    obs-studio.enable = true;
    ygo-omega.enable = true;

    vscode.userSettings = {
      editor = {
        "fontFamily" = mkForce "'MesloLGS Nerd Font'";
        "fontSize" = mkForce 20;
      };
    };
  };

  stylix.fonts = {
    sizes = {
      applications = mkForce 12;
      desktop = mkForce 12;
      popups = mkForce 10;
      terminal = mkForce 14;
    };
    sansSerif = mkForce {
      name = "MesloLGS Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
    };
    serif = mkForce {
      name = "MesloLGS Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
    };
    monospace = mkForce {
      name = "MesloLGS Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
    };
    emoji = mkForce {
      name = "MesloLGS Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
    };
  };

  # monitors for hyprland
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-3, 2560x1440, 0x0, 1"
    "DP-2, 2560x1440, 0x0, 1"
    "HDMI-A-1, 1920x1080@74.97, -1920x0, 1"
  ];

  # monitors for i3
  xsession.windowManager.i3.config.startup = [
    {
      command = ''
        xrandr --output DisplayPort-2 --auto --right-of HDMI-A-0 \
               --output DisplayPort-2 --mode 2560x1440 \
               --output HDMI-A-0 --mode 1920x1080 --rate 74.97 \
      '';
      always = false;
      notification = false;
    }
  ];
}
