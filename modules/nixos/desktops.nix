{ pkgs, config, lib, ... }:
{
  # resolve for gnome and cinnamon confliction.
  environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce "/nix/store/bmn25wcr6rp682bkyvjsj7yddlln4ldv-cinnamon-gsettings-overrides/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.sddm.enable = true;
    desktopManager = {
      gnome.enable = true;
      plasma5.enable = true;
      cinnamon.enable = true;
    };
  };

  # stuff for the desktops
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs.dconf.enable = true;
  # resolve conflict for plasma and gnome
  programs.ssh.askPassword = lib.mkForce "/nix/store/0dsjcbp33ibm4zkbhm99d3fxslnaj28v-seahorse-43.0/libexec/seahorse/ssh-askpass";

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-music
    epiphany
    # geary
    gnome-characters
    tali
    iagno
    hitori
    atomix
    yelp
    gnome-contacts
    gnome-initial-setup
  ]);

  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnome.gnome-system-monitor
    #gnomeExtensions.custom-vpn-toggler
    evince
    libsForQt5.kalk # calculator
    libsForQt5.kpmcore # library for partition manager
    partition-manager # KDE partition manager
  ];
}
