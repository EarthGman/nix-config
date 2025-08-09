{ lib, ... }:
{
  options.meta = {
    desktop = lib.mkOption {
      description = "which desktop environment is enabled";
      type = lib.types.str;
      default = "";
      example = "hyprland";
    };

    hostName = lib.mkOption {
      description = "system hostname";
      type = lib.types.str;
      default = "";
      example = "nixos";
    };

    secretsFile = lib.mkOption {
      description = "location of the default sops secrets file";
      type = lib.types.anything;
      default = null;
    };

    stateVersion = lib.mkOption {
      description = "the version of nixos first installed on the system";
      type = lib.types.str;
      #TODO change me in november
      default = "25.11";
    };

    system = lib.mkOption {
      description = "cpu arch";
      type = lib.types.str;
      default = "x86_64-linux";
      example = "aarch64-linux";
    };

    profiles = {
      stylix = lib.mkOption {
        description = "the stylix profile to enable";
        type = lib.types.str;
        default = "ashes";
      };

      tmux = lib.mkOption {
        description = "tmux profile to use";
        type = lib.types.str;
        default = "";
        example = "dracula";
      };
    };
  };
}
