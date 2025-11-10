{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.gman.yazi.enable = lib.mkEnableOption "gman's totally not stolen yazi config";

  config = lib.mkIf config.gman.yazi.enable {
    stylix.targets.yazi.enable = true;

    programs.yazi = {
      enable = true;
      shellWrapperName = lib.mkDefault "y";

      settings = import ./settings.nix {
        inherit pkgs lib config;
      };
    };
  };
}
