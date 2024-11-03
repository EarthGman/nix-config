# extension of home.nix, a gigantic custom HM module
# the reason this file exists is because of a weird behavior with the config top level argument if used in home.nix
{ lib, outputs, config, ... }:
let
  inherit (lib) mkDefault mkOption mkEnableOption types;
  cfg = config.custom;
in
{
  options = {
    custom = {
      editor = mkOption {
        description = "string exported as EDITOR env variable";
        type = types.str;
        default = "nvim";
      };
      terminal = mkOption {
        description = "which terminal emulator is used by default";
        type = types.str;
        default = "kitty";
      };
      fileManager = mkOption {
        description = "preferred gui based fileManager";
        type = types.str;
        default = "nautilus";
      };
      browser = mkOption {
        description = "preferred browser";
        type = types.str;
        default = "firefox";
      };
    };
    xsession = {
      dpms = {
        enable = mkEnableOption "enable dpms, a screensaving feature for x11";
        standby = mkOption {
          description = "time in seconds until dpms standby activation";
          type = types.int;
          default = 600;
        };
        suspend = mkOption {
          description = "time in seconds until dpms suspend activation";
          type = types.int;
          default = 600;
        };
        off = mkOption {
          description = "time in seconds until dpms powers off the monitors";
          type = types.int;
          default = 600;
        };
      };
    };
  };

  config = {
    xsession = let cfg = config.xsession; in {
      profileExtra = (if cfg.dpms.enable then "" else ''
        xset -dpms
      '') + (if cfg.dpms.enable then ''
        xset dpms ${toString cfg.dpms.standby} ${toString cfg.dpms.suspend} ${toString cfg.dpms.poweroff}
      '' else "");
    };
    programs = {
      gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
      git = {
        enable = true;
        userName = mkDefault "";
        userEmail = mkDefault "";
      };
      # allows bat to inherit the stylix theme
      bat.enable = true;

      zsh.enable = mkDefault true;
      firefox.enable = mkDefault (cfg.browser == "firefox");
      brave.enable = mkDefault (cfg.browser == "brave");
      nautilus.enable = mkDefault (cfg.fileManager == "nautilus");
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
    };
  };
}
