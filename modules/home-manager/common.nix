{ lib, config, outputs, ... }:
let
  inherit (lib) mkDefault mkOption types;
in
{
  options.custom = {
    preferredEditor = mkOption {
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
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
    };

    programs = {
      zsh.enable = mkDefault true;
      kitty.enable = mkDefault (config.custom.terminal == "kitty");
      vscode.enable = mkDefault (config.custom.preferredEditor == "codium");
      zed.enable = mkDefault (config.custom.preferredEditor == "zed");
    };
  };
}
