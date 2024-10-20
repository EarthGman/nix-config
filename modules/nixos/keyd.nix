# maps caps lock to escape by default
{ pkgs, lib, config, ... }:
{
  services.keyd = {
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
  environment.systemPackages = lib.mkIf (config.services.keyd.enable) [ pkgs.keyd ];
}
