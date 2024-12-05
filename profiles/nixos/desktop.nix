{ self, inputs, outputs, hostName, pkgs, lib, wallpapers, icons, keys, desktop, users, stateVersion, ... }:
let
  inherit (lib) mkDefault genAttrs;
  enabled = { enable = mkDefault true; };
  home = self + /home.nix;

in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # only import home-manager for users with a desktop
  # creates a home manager config for every user specificed in users list
  home-manager = {
    users = genAttrs users (username:
      import home { inherit pkgs username lib stateVersion; });
    extraSpecialArgs = {
      inherit self inputs outputs wallpapers icons keys hostName desktop;
    };
    backupFileExtension = "bak";
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

  # forces qt dark theme since qt apps dont work well with stylix
  qt = {
    enable = true;
    platformTheme = mkDefault "gnome";
    style = mkDefault "adwaita-dark";
  };

  # some features most desktops would probably want
  modules = {
    display-managers.sddm = enabled;
    pipewire = enabled;
    bluetooth = enabled;
    printing = enabled;
    ifuse = enabled;
    bootloaders.grub = enabled;
  };

  environment.systemPackages = with pkgs; [
    imagemagick # image manipulation
    pamixer # audio
    brightnessctl # brightness
  ];

  # decorate shell ~2.5GB of bloat
  programs = {
    zsh = {
      enableCompletion = mkDefault true;
      syntaxHighlighting = enabled;
      autosuggestions.enable = mkDefault true;
    };

    # required for some stylix to work properly (gtk)
    dconf.enable = true;
  };
}
