{ lib, config, ... }:
let
  cfg = config.programs.rmpc;
in
{
  options.programs.rmpc.imperativeConfig = lib.mkEnableOption "imperative config for rmpc";

  config = {
    programs.rmpc.config = lib.mkIf cfg.imperativeConfig (lib.mkForce "");
  };
}
