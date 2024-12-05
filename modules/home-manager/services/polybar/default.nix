{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault getExe mkForce;
in
{
  # make sure meslo font is installed
  home.packages = lib.mkIf config.services.polybar.enable (with pkgs; [
    nerd-fonts.meslo-lg
  ]);

  services.polybar = {
    script = import ./script.nix { inherit pkgs lib; };
    settings = import ./settings.nix { inherit pkgs mkDefault config getExe; };
  };
  systemd.user.services.polybar = {
    Service.Environment = mkForce [
      # needs commands from /run/current-system. default did not provide path
      "PATH=/run/current-system/sw/bin:${pkgs.polybar}/bin:/run/wrappers/bin"
    ];
    Install.WantedBy = mkForce [ ]; # prevents polybar from launching without a startup script in the TWM configuration
  };
}
