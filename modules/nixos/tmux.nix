{ lib, config, ... }:
let
  inherit (lib) mkIf mkDefault mkEnableOption;
  cfg = config.modules.tmux;
in
{
  options.modules.tmux.enable = mkEnableOption "enable tmux configuration";

  config = mkIf (cfg.enable) {
    programs.tmux = {
      enable = true;
      keyMode = mkDefault "vi";
      clock24 = mkDefault true; # military time is better
      baseIndex = mkDefault 1; # lua has corrupted me
    };
  };

}
