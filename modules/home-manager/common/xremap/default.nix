{ inputs, platform, pkgs, config, lib, ... }:
{
  imports = [
    inputs.xremap.homeManagerModules.default
  ];
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
}
