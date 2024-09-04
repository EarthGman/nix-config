{ displayManager, lib, ... }:
let
  sddm = (displayManager == "sddm");
in
{
  imports = [
    ./sddm.nix
  ];

  custom.sddm.enable = sddm;

  # using services.xserver.enable will enable lightdm by default. This forces it off if no display manager is set
  services.xserver.displayManager.lightdm.enable = lib.mkIf (displayManager == null) lib.mkForce false;
}
