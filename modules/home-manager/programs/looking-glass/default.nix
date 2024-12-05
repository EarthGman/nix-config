{ pkgs, config, lib, ... }:
let
  inherit (lib) mkOption types mkIf;
  cfg = config.programs.looking-glass;
  looking-glass-client =
    if (cfg.version != "latest") then
      (pkgs.looking-glass-client.overrideAttrs rec {
        version = cfg.version;
        patches = [ ];
        src = pkgs.fetchFromGitHub {
          owner = "gnif";
          repo = "LookingGlass";
          rev = version;
          sha256 = "sha256-6vYbNmNJBCoU23nVculac24tHqH7F4AZVftIjL93WJU=";
          fetchSubmodules = true;
        };
      })
    else
      pkgs.looking-glass-client;
in
{
  options.programs.looking-glass = {
    enable = lib.mkEnableOption "enable looking-glass-client";
    version = mkOption {
      description = "set version of looking glass";
      type = types.str;
      default = "latest";
    };
  };
  config = mkIf cfg.enable {
    home.packages = [ looking-glass-client ];
  };
}
