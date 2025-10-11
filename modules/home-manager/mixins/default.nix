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
      password-store.enable = lib.mkDefault true;
      lh-mouse.enable = lib.mkDefault (
        nixosConfig != null && nixosConfig.services.libinput.mouse.leftHanded
      );

      profiles = {
        stylix = enableProfile "stylix";
        conky = enableProfile "conky";
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
      # defaults are terminal based for servers
      # see home-manager/mixins/desktop.nix for defaults with a desktop environment installed
      browser = lib.mkDefault "lynx";
      fileManager = lib.mkDefault "yazi";
      editor = lib.mkDefault "nano";

      profiles = {
        desktopTheme = lib.mkDefault "";
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
        pkgs.file
      ]
      ++ lib.optionals (pkgs.stdenv.isLinux) [
        pkgs.coreutils-full
      ];
      sessionVariables.EDITOR = lib.mkDefault config.meta.editor;
    };

    programs = {
      nix-inspect.enable = lib.mkDefault true;
      thunderbird.imperativeConfig = lib.mkDefault true;

      # browsers
      firefox.enable = lib.mkDefault (config.meta.browser == "firefox");
      qutebrowser.enable = lib.mkDefault (config.meta.browser == "qutebrowser");
      brave.enable = lib.mkDefault (config.meta.browser == "brave");
      lynx.enable = lib.mkDefault (config.meta.browser == "lynx");

      # File managers
      nautilus.enable = lib.mkDefault (config.meta.fileManager == "nautilus");
      dolphin.enable = lib.mkDefault (config.meta.fileManager == "dolphin");
      yazi.enable = lib.mkDefault (config.meta.fileManager == "yazi");

      # terminal emulators
      kitty.enable = lib.mkDefault (config.meta.terminal == "kitty");
      ghostty.enable = lib.mkDefault (config.meta.terminal == "ghostty");

      # Editors
      vscode.enable = lib.mkDefault (config.meta.editor == "vscode");
      neovim.enable = lib.mkDefault (config.meta.editor == "nvim");
      gnome-text-editor.enable = lib.mkDefault (config.meta.editor == "gnome-text-editor");

      # Image viewers
      gthumb.enable = lib.mkDefault (config.meta.imageViewer == "gthumb");
      gwenview.enable = lib.mkDefault (config.meta.imageViewer == "gwenview");

      # Media players
      vlc.enable = lib.mkDefault (config.meta.mediaPlayer == "vlc");
      mpv.enable = lib.mkDefault (config.meta.mediaPlayer == "mpv");
      totem.enable = lib.mkDefault (config.meta.mediaPlayer == "totem");

      # others
      fastfetch.enable = lib.mkDefault true;
      gh.enable = lib.mkDefault true;
      waybar.systemd.enable = lib.mkDefault true;

      ssh = {
        enableDefaultConfig = false;
      };

      nh = {
        enable = lib.mkDefault true;
        # only enable clean if nixos doesn't already have cleaning enabled
        clean.enable = if (nixosConfig != null) then (!nixosConfig.programs.nh.clean.enable) else true;
      };
      gpg.enable = lib.mkDefault true;
    };

    services = {
      swaync.settings = {
        positionY = lib.mkDefault "bottom";
      };
      gpg-agent = {
        pinentry.package = lib.mkDefault pkgs.pinentry-tty;
        enableSshSupport = lib.mkDefault true;
      };
    };

    xdg = {
      #   mimeApps = {
      #     # allow imperative xdg config through nautilus on gnome by default
      #     enable = lib.mkDefault (config.meta.desktop != "gnome");
      #     defaultApplications = {
      #       "application/pdf" = lib.mkDefault [
      #         "org.gnome.Evince.desktop"
      #         "firefox.desktop"
      #       ];
      #       "image/png" = lib.mkDefault [
      #         "org.gnome.gThumb.desktop"
      #         "gimp.desktop"
      #       ];
      #       "image/jpeg" = lib.mkDefault [
      #         "org.gnome.gThumb.desktop"
      #         "gimp.desktop"
      #       ];
      #       "image/webp" = lib.mkDefault [
      #         "org.gnome.gThumb.desktop"
      #         "gimp.desktop"
      #       ];
      #       "image/gif" = lib.mkDefault [
      #         "org.gnome.gThumb.desktop"
      #         "gimp.desktop"
      #       ];
      #       "video/mp4" = lib.mkDefault [
      #         "vlc.desktop"
      #         "org.gnome.gitlab.YaLTeR.VideoTrimmer.desktop"
      #       ];
      #     };
      #   };

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
