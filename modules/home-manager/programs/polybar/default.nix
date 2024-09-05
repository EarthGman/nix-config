{ pkgs, config, lib, ... }:
let
  inherit (lib) mkDefault;
in
{
  options.custom.polybar.enable = lib.mkEnableOption "enable polybar";
  config = lib.mkIf config.custom.polybar.enable {
    # make sure meslo font is installed
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];

    services.polybar = {
      enable = true;
      # the systemd unit cannot find user level packages such as: brightnessctl, pamixer, etc
      # home-manager will complain if this is not set so it is forced to do nothing
      script = "";
      settings = import ./settings.nix { inherit pkgs mkDefault; };
    };
  };
}
