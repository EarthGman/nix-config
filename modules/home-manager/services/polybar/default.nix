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
    script = import ./script.nix { inherit pkgs lib; };
    settings = import ./settings.nix { inherit pkgs mkDefault config getExe; };
  };

  #TODO figure out how to stop polybar if waybar wants to launch first
  systemd.user.services.polybar = {
    Service = {
      Environment = mkForce [
        # needs commands from /run/current-system. default did not provide path
        "PATH=/run/current-system/sw/bin:${pkgs.polybar}/bin:/run/wrappers/bin"
      ];
    };

    # forces the service to be manually invoked by xorg desktops
    Install.WantedBy = mkForce [ ];
  };
}
