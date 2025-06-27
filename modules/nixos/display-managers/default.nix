{ lib, ... }@args:
let
  inherit (lib) mkDefault;
  # extract a preferred desktop envrionment from the first one specified in the string
  desktop = if args ? desktop then args.desktop else null;
  preferredDesktop =
    if (desktop != null) then
      builtins.elemAt (lib.splitString "," desktop) 0
    else
      null;

  defaultSession =
    if (preferredDesktop == "i3") then
      "none+i3"
    else if (preferredDesktop == "hyprland") then
      "hyprland-uwsm"
    else if (preferredDesktop == "sway") then
      "sway-uwsm"
    else
      preferredDesktop;
in
{
  imports = [
    ./sddm.nix
  ];

  config = {
    services.displayManager = {
      defaultSession = mkDefault defaultSession;
    };
  };
}
