# not to be interpreted as "desktop PC" but module for any machine that has a desktop environment
{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.desktop;
in
{
  options.gman.desktop.enable = lib.mkEnableOption "gman's configuration for hosts with a desktop environment";
  config = lib.mkIf cfg.enable {
    # configuration revelent for desktop
    gman = {
      # sound
      pipewire.enable = lib.mkDefault true;
      bluetooth.enable = lib.mkDefault true;

      # common printing configuration
      printing.enable = lib.mkDefault true;

      # which desktop to enable
      hyprland.enable = (config.meta.desktop == "hyprland");
      sway.enable = (config.meta.desktop == "sway");
      # gnome.enable = (config.meta.desktop == "gnome");
      plasma.enable = (config.meta.desktop == "plasma");

      # installs various hardware monitoring and configuration tools
      hardware-tools.enable = lib.mkDefault true;
    };

    # additional boilerplate
    boot = {
      extraModulePackages = [
        # for obs virtual camera
        config.boot.kernelPackages.v4l2loopback
      ];
    };

    environment.systemPackages = [
      # install some icons
      pkgs.adwaita-icon-theme
      pkgs.star-pixel-icons

      # install some cursors
      pkgs.bibata-cursors

      # backport of libadwaita to gtk3
      # required for many legacy gtk3 apps to respect custom color schemes
      pkgs.adw-gtk3

    ]
    ++ lib.optionals (config.programs.dconf.enable) [
      pkgs.dconf-editor
    ];

    # install some fonts
    fonts.packages = builtins.attrValues (
      {
        inherit (pkgs)
          pixel-code
          "8-bit-operator-font"
          omori-font
          ;
      }
      # nerd fonts
      // {
        inherit (pkgs.nerd-fonts)
          meslo-lg
          ;
      }
    );

    # kind of redundant, but good to have.
    hardware.graphics = {
      enable = true;
      enable32Bit = lib.mkDefault true;
    };

    # mounting network drives in file managers
    services.gvfs.enable = lib.mkDefault true;

    # simple flatpak using discover by default
    services.flatpak.enable = lib.mkDefault true;
    programs = {
      gnome-software.enable = lib.mkDefault config.services.flatpak.enable;
      # overcomplicated gtk settings database
      dconf.enable = lib.mkDefault true;
    };

    # use sddm as default display manager, will change to gdm if gnome is the desktop
    services.displayManager.sddm.enable = lib.mkDefault true;

    # ensure xserver configuration is applied
    services.xserver = {
      enable = lib.mkDefault true;
      excludePackages = builtins.attrValues {
        inherit (pkgs)
          xterm
          ;
      };
    };

    # sets up a default desktop portal backend
    xdg.portal = {
      enable = lib.mkDefault true;
      xdgOpenUsePortal = true;
    };

    # graphical prompt for sudo
    security.polkit.enable = lib.mkDefault true;

    # use kvantum themes
    qt = {
      enable = lib.mkDefault true;
      platformTheme = "kde";
      style = "kvantum";
    };
  };
}
