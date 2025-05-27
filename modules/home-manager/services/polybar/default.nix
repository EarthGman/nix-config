{ lib, config, ... }:
let
  inherit (lib) mkForce mkDefault;
in
{
  services.polybar.script = mkDefault (import ./script.nix);
  systemd.user.services.polybar = {
    Service = {
      Environment = mkForce [
        "PATH=${config.home.homeDirectory}/.nix-profile/bin:/run/wrappers/bin"
      ];
    };

    # forces the service to be manually invoked by xorg desktops
    # the reason I want this is so that sway and i3 can be enabled at the same time without have 2 bars
    Install.WantedBy = mkForce [ ];
  };
}
