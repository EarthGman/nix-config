{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkIf getExe mkForce;
in
{
  # make sure meslo font is installed
  home.packages = mkIf config.services.polybar.enable (with pkgs; [
    nerd-fonts.meslo-lg
  ]);

  services.polybar = {
    script = import ./script.nix;
    settings = import ./settings.nix { inherit pkgs mkDefault config getExe; };
  };

  systemd.user.services.polybar = {
    Service = {
      Environment = mkForce [
        "PATH=${config.home.homeDirectory}/.nix-profile/bin:/run/wrappers/bin"
      ];
    };

    # forces the service to be manually invoked by xorg desktops
    Install.WantedBy = mkForce [ ];
  };
}
