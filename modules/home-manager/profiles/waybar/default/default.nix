{ pkgs, lib, config, ... }@args:
let
  nixosConfig = if args ? nixosConfig then args.nixosConfig else null;
  inherit (lib) mkIf mkDefault mkEnableOption;
  inherit (builtins) readFile;
  cfg = config.profiles.waybar.default;
  scripts = import ../../../scripts { inherit pkgs lib config; };

  smallSettings = {
    height = 30;
    network = {
      format-wifi = " {icon} {essid}";
      format-ethernet = " 󰈁 {ifname}";
      format-disconnected = "󰤭  Disconnected ";
      format-icons = [
        "󰤯 "
        "󰤟 "
        "󰤢 "
        "󰤢 "
        "󰤨 "
      ];
      interval = 5;
      tooltip = "true";
      tooltip-format = "LAN: {ipaddr}";
    };
  };

in
{
  options.profiles.waybar.default = {
    enable = mkEnableOption "default waybar profile";
    small = mkEnableOption "a smaller default waybar";
  };

  config = mkIf cfg.enable {
    home.packages = mkIf config.programs.waybar.enable (with pkgs.nerd-fonts; [ meslo-lg ]);
    services.network-manager-applet.enable =
      if (nixosConfig != null && config.programs.waybar.enable) then
        if (nixosConfig.networking.networkmanager.enable) then
          mkDefault true
        else
          false
      else
        false;

    services.blueman-applet.enable =
      if (nixosConfig != null && config.programs.waybar.enable) then
        if (nixosConfig.services.blueman.enable) then
          mkDefault true
        else
          false
      else
        false;

    stylix.targets.waybar = {
      addCss = mkDefault false;
    };
    programs.waybar = {
      bottomBar.settings = import ./bottom.nix { inherit pkgs lib config scripts; } // (if (cfg.small) then
        smallSettings else { });
      style =
        if (cfg.small) then
          (readFile ./small.css)
        else
          (readFile ./style.css);
    };
    xdg.configFile = {
      "waybar/settings-menu.xml" = {
        enable = config.programs.waybar.enable && !config.programs.waybar.imperativeConfig;
        text = mkDefault (builtins.readFile ./settings-menu.xml);
      };
    };
  };
}
