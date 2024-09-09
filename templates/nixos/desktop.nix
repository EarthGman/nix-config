{ self, inputs, outputs, hostName, pkgs, lib, myLib, wallpapers, icons, config, desktop, username, stateVersion, ... }:
let
  inherit (lib) mkDefault mkIf;
  enabled = { enable = mkDefault true; };
  user = self + /hosts/${hostName}/users/${username};
  home = self + /home.nix;
in
{
  imports = [
    inputs.home-manager.nixosModules.default
    user
  ];

  # creates a home manager config for every user specificed in users string
  # home-manager = {
  #   users = genAttrs usernames (username:
  #     import ../home.nix { inherit username outputs pkgs lib stateVersion; });

  # only import home-manager for users with a desktop
  home-manager = {
    users.${username} = import home;
    extraSpecialArgs = {
      inherit self inputs outputs wallpapers icons hostName username desktop myLib stateVersion;
    };
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
  # decorate shell for root ~2.5GB of bloat
  programs = {
    zsh = {
      enableCompletion = mkDefault true;
      syntaxHighlighting = enabled;
      autosuggestions.enable = mkDefault true;
    };
    starship = enabled;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # required for some stylix to work properly (gtk)
    dconf.enable = true;
  };

  # for most desktop users editing the config from the home directory is preferred over /etc/nixos
  # this links the /etc/nixos directory to ~/src/nix-config
  # environment.etc."nixos".source = /home/${username}/src/nix-config;

  # if you have dolphin emu installed GC controllers will not have correct permissions unless set
  # services.udev.packages = mkIf config.home-manager.users.${username}.custom.dolphin-emu.enable [ pkgs.dolphinEmu ];
}
