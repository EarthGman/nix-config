{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  enableProfile =
    profile:
    let
      cfg = config.meta.profiles;
    in
    if (cfg.${profile} != "") then
      {
        ${cfg.${profile}}.enable = true;
      }
    else
      { };
in
{
  imports = lib.autoImport ./.;

  options.gman.enable = lib.mkEnableOption "gman's home-manager modules";

  config = lib.mkIf config.gman.enable {
    # custom options
    gman = {
      desktop.enable = (config.meta.desktop != "");
      zsh.enable = lib.mkDefault true;
      kitty.enable = lib.mkDefault (config.meta.terminal == "kitty");
      yazi.enable = lib.mkDefault true;
      sops.enable = (config.meta.secretsFile != null);

      suites = {
        lh-mouse.enable = lib.mkDefault (
          nixosConfig != null && nixosConfig.services.libinput.mouse.leftHanded
        );
      };

      profiles = {
        stylix = enableProfile "stylix";
        desktopThemes = enableProfile "desktopTheme";
        firefox = enableProfile "firefox";
        fastfetch = enableProfile "fastfetch";
        rofi = enableProfile "rofi";
        waybar = enableProfile "waybar";
      };
    };

    meta = {
      browser = lib.mkDefault "firefox";
      terminal = lib.mkDefault "kitty";
      fileManager = lib.mkDefault "nautilus";
      #TODO move the assets repo to a website
      wallpaper = lib.mkDefault (builtins.fetchurl pkgs.wallpapers.default);

      profiles = {
        desktopTheme = lib.mkDefault "astronaut";
        firefox = lib.mkDefault "betterfox";
        fastfetch = lib.mkDefault "default";
        waybar = lib.mkDefault "windows-11";
        rofi = lib.mkDefault "material-dark";
      };
    };

    # stock home-manager modules
    # -------------------------------------------------------------

    home.packages = [
      pkgs.coreutils-full
    ];

    programs = {
      firefox.enable = (config.meta.browser == "firefox");
      nautilus.enable = (config.meta.fileManager == "nautilus");
      kitty.enable = (config.meta.terminal == "kitty");
      ghostty.enable = (config.meta.terminal == "ghostty");

      fastfetch.enable = lib.mkDefault true;
      waybar.systemd.enable = lib.mkDefault true;
      eza.enable = lib.mkDefault true;
      # works on both x11 and wayland
      rofi.package = lib.mkDefault pkgs.rofi-wayland;
      nh = {
        enable = lib.mkDefault true;
        # only enable clean if nixos doesn't already have cleaning enabled
        clean.enable = (nixosConfig != null && !nixosConfig.programs.nh.clean.enable);
      };
    };

    services.swaync.settings = {
      positionY = lib.mkDefault "bottom";
    };
  };
}
