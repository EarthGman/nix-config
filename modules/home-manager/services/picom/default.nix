{ lib, ... }:
{
  services.picom = {
    backend = "glx";
    vSync = true;
  };
  # let the service fail if it tries to start in a non x11 environment
  systemd.user.services.picom = {
    Service.Restart = lib.mkForce "no";
  };
}
