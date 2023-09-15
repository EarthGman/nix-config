{ pkgs, ... }:
{
  users.users = {
    g = {
      # You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      #initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg"
      ];
      # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ 
        "networkmanager"
        "wheel" 
        "libvirtd"
        "nordvpn"
      ];
      shell = pkgs.zsh;
    };
  };
}