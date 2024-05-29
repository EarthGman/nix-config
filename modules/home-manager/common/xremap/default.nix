{ inputs, platform, pkgs, config, lib, ... }:
{
  imports = [
    inputs.xremap.homeManagerModules.default
  ];
  options.xremap.enable = lib.mkEnableOption "enable xremap";
  config = lib.mkIf config.xremap.enable {
    home.packages = [
      inputs.xremap.packages.${platform}.default
    ];
    services.xremap = {
      withX11 = true;
      yamlConfig = ''
        modmap:
          - name: universal
            remap:
              Capslock: esc
      '';
    };
  };
}
