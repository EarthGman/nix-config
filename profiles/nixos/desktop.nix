{ pkgs, lib, config, users, ... }:
let
  inherit (lib) mkDefault optionals;
  enabled = { enable = mkDefault true; };
in
{
  boot = {
    tmp.cleanOnBoot = true;
    extraModulePackages = [
      # for obs virtual camera
      config.boot.kernelPackages.v4l2loopback
    ];
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = mkDefault true;
  };

  # mounting network drives in file managers
  services.gvfs.enable = mkDefault true;

  services.xserver = {
    enable = true;
    xkb.layout = mkDefault "us";
    excludePackages = with pkgs; [ xterm ];
  };

  # sets up a default desktop portal backend
  xdg.portal = {
    enable = true;
    extraPortals = mkDefault [ pkgs.xdg-desktop-portal ];
  };

  security.polkit.enable = true; # graphical prompt for sudo

  # forces qt dark theme since qt apps dont work well with stylix
  qt = {
    enable = true;
    platformTheme = mkDefault "gnome";
    style = mkDefault "adwaita-dark";
  };

  # some features most desktops would probably want
  modules = {
    home-manager.enable = mkDefault users != [ ];
    display-managers.sddm = enabled;
    pipewire = enabled;
    bluetooth = enabled;
    printing = enabled;
    bootloaders.grub = enabled;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # brightness
  ] ++ optionals (config.modules.pipewire.enable) [
    pamixer
  ];

  # required for some stylix to work properly (gtk)
  programs.dconf.enable = true;
}
