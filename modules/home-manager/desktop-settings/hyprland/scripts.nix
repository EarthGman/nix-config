{ pkgs, lib, config, ... }:
let
  inherit (lib) getExe;
in
{
  waybar = pkgs.writeScript "waybar.sh" ''
    ${lib.getExe pkgs.killall} .waybar-wrapped
    ${lib.getExe pkgs.waybar} &
    exit 0
  '';

  take-screenshot-selection = pkgs.writeScript "take-screenshot-selection-wayland.sh" ''
    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi
    timestamp=$(date +%F_%T)
    output="${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-''${timestamp}.png"

    if selection=$(${getExe pkgs.slurp}) && ${getExe pkgs.grim} -g "$selection" - | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';

  take-screenshot = pkgs.writeScript "take-screenshot-wayland.sh" ''
    if [ ! -d ${config.home.homeDirectory}/Pictures/Screenshots ]; then
      mkdir -p ${config.home.homeDirectory}/Pictures/Screenshots
    fi
    timestamp=$(date +%F_%T)
    output="${config.home.homeDirectory}/Pictures/Screenshots/Screenshot-''${timestamp}.png"
    
    if ${getExe pkgs.grim} - | ${pkgs.wl-clipboard}/bin/wl-copy; then
      ${pkgs.wl-clipboard}/bin/wl-paste > "$output"
      dunstify 'Screenshot saved to ~/Pictures/Screenshots'
    fi
  '';
}
