{ pkgs, config, lib, ... }:
{
  # resolve for gnome and cinnamon confliction.
  environment.sessionVariables.NIX_GSETTINGS_OVERRIDES_DIR = lib.mkForce "/nix/store/bmn25wcr6rp682bkyvjsj7yddlln4ldv-cinnamon-gsettings-overrides/share/gsettings-schemas/nixos-gsettings-overrides/glib-2.0/schemas";

  # resolve conflict for plasma and gnome
  programs.ssh.askPassword = lib.mkForce "/nix/store/0dsjcbp33ibm4zkbhm99d3fxslnaj28v-seahorse-43.0/libexec/seahorse/ssh-askpass";

  services.xserver = {
    enable = true;
    xkb.layout = "us";
  };
  qt = {
    enable = true;
  };
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; ([
    gnome.gnome-system-monitor
  ]) ++ (with pkgs.libsForQt5; [
    dolphin
  ]);
}
