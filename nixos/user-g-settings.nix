{ pkgs, ... }:
{
  users.users.g = {
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
