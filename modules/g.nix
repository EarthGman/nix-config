{ pkgs, ... }:
#configuration for user g
let
  ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
in
{
  users.users.g = {
    openssh.authorizedKeys.keys = [
      ssh-key
    ];
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [
      "nordvpn"
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
  programs.git = {
    enable = true;
    config = {
      user = {
        name = "g";
        email = "117403037+EarthGman@users.noreply.github.com";
      };
    };
  };
}
