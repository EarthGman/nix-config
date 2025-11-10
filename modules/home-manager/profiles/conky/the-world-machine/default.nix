{ lib, config, ... }:
let
  cfg = config.gman.profiles.conky.the-world-machine;
in
{
  options.gman.profiles.conky.the-world-machine.enable =
    lib.mkEnableOption "conky config for the world machine theme";

  config = lib.mkIf cfg.enable {
    services.conky.extraConfig = import ./config.nix { inherit config; };
  };
}
