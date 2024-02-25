{ pkgs, config, lib, ... }:
{
  # resolve for gnome and cinnamon confliction.
  environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce "/nix/store/bmn25wcr6rp682bkyvjsj7yddlln4ldv-cinnamon-gsettings-overrides/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";
  # resolve conflict for plasma and gnome
  programs.ssh.askPassword = lib.mkForce "/nix/store/0dsjcbp33ibm4zkbhm99d3fxslnaj28v-seahorse-43.0/libexec/seahorse/ssh-askpass";
  # force disable geary for gnome and cinnamon
  programs.geary.enable = false;

  services.xserver = {
    enable = true;
    xkb.layout = "us";
    displayManager.sddm.enable = true;
    desktopManager = {
      gnome.enable = true;
      plasma5.enable = true;
      cinnamon.enable = true;
    };
  };

  programs.dconf.enable = true;
  # stuff for the desktops
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.gnome.excludePackages = (with pkgs; [
    weather
    gnome-photos
    gnome-tour
    gedit
    hexchat
    loupe
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    geary
    gnome-characters
    nautilus
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ]);

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    ark
    elisa
    gwenview
    konsole
    kwalletmanager
    okular
    pix
    spectacle
  ];

  environment.cinnamon.excludePackages = (with pkgs; [
    hexchat
    weather
    xed-editor
  ]) ++ (with pkgs.cinnamon; [
    nemo
    pix
  ]);

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.gnome-system-monitor
    #gnomeExtensions.custom-vpn-toggler
  ];
}
