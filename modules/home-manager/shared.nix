# extension of home.nix
# the reason this file exists is because of a weird behavior with the config top level argument if used in home.nix
{ lib, outputs, ... }:
let
  inherit (lib) mkDefault mkOption types;
in
{
  options.custom = {
    editor = mkOption {
      description = "string exported as EDITOR env variable";
      default = "nano";
      type = types.str;
    };
    terminal = mkOption {
      description = "which terminal emulator is used by default";
      default = "kitty";
      type = types.str;
    };
  };

  config = {
    # enable gh for all users
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
      bat.enable = true;
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
    };

    programs = {
      zsh.enable = mkDefault true;
    };
  };
}
