{ pkgs, lib, ... }:
let
  inherit (lib) mkDefault getExe;
in
{
  # make sure meslo font is installed
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Meslo" ]; })
  ];

  services.polybar = {
    # the systemd unit cannot find user level packages such as: brightnessctl, pamixer, etc
    # home-manager will complain if this is not set so it is forced to do nothing
    script = "";
    settings = import ./settings.nix { inherit pkgs mkDefault getExe; };
  };
}
