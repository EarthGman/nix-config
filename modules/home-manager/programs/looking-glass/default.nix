{ pkgs, config, lib, ... }:
let
  inherit (lib) mkEnableOption mkOption types mkIf optionals;
  cfg = config.looking-glass;
  looking-glass-client =
    if (cfg.version != "B7-rc1") then
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
  options.looking-glass = {
    enable = lib.mkEnableOption "enable looking-glass-client";
    version = mkOption {
      description = "set version of looking glass";
      type = types.str;
      default = "B7-rc1";
    };
  };
  config = {
    home.packages = mkIf cfg.enable [ looking-glass-client ];
  };
}