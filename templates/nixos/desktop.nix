{ self, inputs, outputs, hostName, pkgs, lib, myLib, wallpapers, icons, desktop, users, stateVersion, ... }:
let
  inherit (lib) mkDefault genAttrs;
  enabled = { enable = mkDefault true; };
  home = self + /home.nix;
  usernames = myLib.splitToList users;

in
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # only import home-manager for users with a desktop
  # creates a home manager config for every user specificed in users string
  home-manager = {
    users = genAttrs usernames (username:
      import home { inherit pkgs username hostName myLib stateVersion; });
    extraSpecialArgs = {
      inherit self inputs outputs wallpapers icons hostName desktop myLib;
    };
    backupFileExtension = "bak";
  };

  services.xserver = {
    enable = true;
    xkb.layout = mkDefault "us";
    excludePackages = with pkgs; [ xterm ];
  };

  xdg.portal = {
    enable = true;
    configPackages = [ pkgs.xdg-desktop-portal ];
    extraPortals = [ pkgs.xdg-desktop-portal ];
  };

  # forces qt dark theme since qt apps dont work well with stylix
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  custom = {
    sound = enabled;
    bluetooth = enabled;
    printing = enabled;
    ifuse = enabled;
    grub = enabled;
  };
  # decorate shell ~2.5GB of bloat
  programs = {
    zsh = {
      enableCompletion = mkDefault true;
      syntaxHighlighting = enabled;
      autosuggestions.enable = mkDefault true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # required for some stylix to work properly (gtk)
    dconf.enable = true;
  };
}
