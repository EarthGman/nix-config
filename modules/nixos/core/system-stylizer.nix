{ lib, config, ... }@args:
let
  wallpapers = if args ? wallpapers then args.wallpapers else null;
  inherit (builtins) fetchurl;
  inherit (lib)
    mkEnableOption
    mkOption
    mkIf
    mkMerge
    types
    optionals
    ;

  cfg = config.modules.system-stylizer;
  # set the default user to the first one that appears in the users list
  primaryUser = if args ? users then builtins.elemAt args.users 0 else "";

  # handle possible cases of things not existing. Maybe nix has some kind of try catch?
  theme =
    if
      (
        config ? home-manager
        && config.home-manager.users ? "${cfg.user}"
        && config.home-manager.users."${cfg.user}" ? custom
      )
    then
      config.home-manager.users.${cfg.user}.custom.profiles.desktopTheme
    else
      null;
in
{
  options.modules.system-stylizer = {
    enable = mkEnableOption ''
      automatic stylization of nixos configuration based on the desktop theme chosen by the specified user's home-manager configuration
    '';
    user = mkOption {
      description = "username whose home-manager configuration controls system stylization";
      type = types.str;
      default = primaryUser;
    };
  };

  config = mkIf cfg.enable (
    mkMerge (
      [
        (mkIf (cfg.user == "") {
          warnings = [
            ''
              No user could be detected by modules.system-stylizer.enable.
              Please specify a username with a valid home-manager configuration (one that contains custom.profiles.desktopThemes)
              under modules.system-stylizer.users, or disable the module by setting modules.system-stylizer.enable = false in your configuration.nix.
            ''
          ];
        })
        (mkIf (!config.home-manager.users ? "${cfg.user}" && "${cfg.user}" != "") {
          warnings = [
            ''
              modules.system-stylizer.enable = true, but no home-manager configuration for the user specified under
              modules.system-stylizer.user was found. Ensure that a home-manager configuration for user '${cfg.user}' exists.
              or disable the module by adding modules.system-stylizer.enable = false to your configuration.nix.
            ''
          ];
        })
        (mkIf (wallpapers == null) {
          warnings = [
            "modules.system-stylizer.enable = true, but no wallpapers were found. Be sure to create NixOS configuration using the mkHost wrapper function to obtain them."
          ];
        })
      ]
      ++ optionals (wallpapers != null) [
        (mkIf (theme == "april") {
          boot.loader.grub.themeConfig = {
            background = fetchurl wallpapers.april-red;
          };
          services.displayManager.sddm.themeConfig = {
            Background = fetchurl wallpapers.kaori;
          };
        })
        (mkIf (theme == "undertale") {
          services.displayManager.sddm.themeConfig = {
            Background = fetchurl wallpapers.mt-ebott;
            ScreenWidth = "1366";
            ScreenHeight = "768";
            FullBlur = "false";
            PartialBlur = "false";
            MainColor = "#352500";
            AccentColor = "#df8b25";
            BackgroundColor = "#ffffff";
            placeholderColor = "#ffffff";
            IconColor = "#df8b25";
            FormPosition = "center";
            Font = "DejaVuSans 12";
            FontSize = "10";
            HourFormat = "hh:mm A";
          };
        })
        (mkIf (theme == "faraway") {
          services.displayManager.sddm.themeConfig = {
            Background = builtins.fetchurl wallpapers.the-gang-grouphug;
            ScreenWidth = "2560";
            ScreenHeight = "1440";
            FullBlur = "false";
            PartialBlur = "false";
            MainColor = "#FFFFFF";
            AccentColor = "#f099ff";
            BackgroundColor = "#ffffff";
            placeholderColor = "#ffffff";
            IconColor = "#ffffff";
            FormPosition = "left";
            Font = "DejaVuSans 12";
            HourFormat = "hh:mm A";
          };
        })
        (mkIf (theme == "hollow-knight") {
          boot.loader.grub.themeConfig = {
            background = builtins.fetchurl wallpapers.hollow-knight-minimal;
          };
          services = {
            displayManager = {
              sddm = {
                themeConfig = {
                  Background = builtins.fetchurl wallpapers.hallownest;
                  ScreenWidth = "2560";
                  ScreenHeight = "1440";
                  FullBlur = "false";
                  PartialBlur = "false";
                  FormPosition = "right";
                  MainColor = "#cd4967";
                  AccentColor = "#000000";
                  BackgroundColor = "#000000";
                  placeholderColor = "#302a19";
                  IconColor = "#cd4967";
                  HourFormat = "hh:mm A";
                  FontSize = "16";
                };
              };
            };
          };
        })
      ]
    )
  );
}
