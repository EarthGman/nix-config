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
      lh-mouse.enable = lib.mkDefault (
        nixosConfig != null && nixosConfig.services.libinput.mouse.leftHanded
      );

      profiles = {
        stylix = enableProfile "stylix";
        desktopThemes = enableProfile "desktopTheme";
        firefox = enableProfile "firefox";
        fastfetch = enableProfile "fastfetch";
        waybar = enableProfile "waybar";
        eww = enableProfile "eww";
        rofi = enableProfile "rofi";
      };
    };

    # set metadata
    meta = {
      browser = lib.mkDefault "firefox";
      terminal = lib.mkDefault "kitty";
      fileManager = lib.mkDefault "nautilus";
      editor = lib.mkDefault "nano";

      wallpaper = lib.mkDefault pkgs.images.default;

      profiles = {
        desktopTheme = lib.mkDefault "astronaut";
        firefox = lib.mkDefault "betterfox";
        fastfetch = lib.mkDefault "default";
        waybar = lib.mkDefault "windows-11";
        eww = lib.mkDefault "default";
        rofi = lib.mkDefault "material-dark";
      };
    };

    # stock home-manager modules
    # -------------------------------------------------------------

    home = {
      packages = [
        pkgs.home-manager
      ]
      ++ lib.optionals (pkgs.stdenv.isLinux) [
        pkgs.coreutils-full
      ];
      sessionVariables.EDITOR = lib.mkDefault config.meta.editor;
    };

    programs = {
      firefox.enable = (config.meta.browser == "firefox");
      brave.enable = (config.meta.browser == "brave");
      thunderbird.imperativeConfig = lib.mkDefault true;

      nautilus.enable = (config.meta.fileManager == "nautilus");
      dolphin.enable = (config.meta.fileManager == "dolphin");

      kitty.enable = (config.meta.terminal == "kitty");
      ghostty.enable = (config.meta.terminal == "ghostty");

      vscode.enable = (config.meta.editor == "codium");
      neovim.enable = (config.meta.editor == "nvim");
      vim.enable = (config.meta.editor == "vim");

      fastfetch.enable = lib.mkDefault true;
      gh.enable = lib.mkDefault true;
      waybar.systemd.enable = lib.mkDefault true;
      # works on both x11 and wayland
      rofi.package = lib.mkDefault pkgs.rofi-wayland;

      ssh = {
        enableDefaultConfig = false;
      };

      nh = {
        enable = lib.mkDefault true;
        # only enable clean if nixos doesn't already have cleaning enabled
        clean.enable = if (nixosConfig != null) then (!nixosConfig.programs.nh.clean.enable) else true;
      };
    };

    services = {
      swaync.settings = {
        positionY = lib.mkDefault "bottom";
      };
    };

    xdg = {
      mimeApps = {
        # allow imperative xdg config through nautilus on gnome by default
        enable = lib.mkDefault (config.meta.desktop != "gnome");
        defaultApplications = {
          "application/pdf" = lib.mkDefault [
            "org.gnome.Evince.desktop"
            "firefox.desktop"
          ];
          "image/png" = lib.mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "image/jpeg" = lib.mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "image/webp" = lib.mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "image/gif" = lib.mkDefault [
            "org.gnome.gThumb.desktop"
            "gimp.desktop"
          ];
          "video/mp4" = lib.mkDefault [
            "vlc.desktop"
            "org.gnome.gitlab.YaLTeR.VideoTrimmer.desktop"
          ];
        };
      };

      userDirs = {
        # enable and create common Directories (Downloads, Documents, Music, etc)
        enable = lib.mkDefault true;
        createDirectories = lib.mkDefault true;
      };
    };

    home.sessionVariables = {
      # required for some scripts
      XDG_SCREENSHOTS_DIR = lib.mkDefault "${config.xdg.userDirs.pictures}/screenshots";
    };
  };
}
