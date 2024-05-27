{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
  };
  users.users.g = {
    isNormalUser = true;
    description = "g";
    shell = pkgs.zsh;
    # passwd = "";
    extraGroups = [
      "networkmanager"
      "wheel"
      "nordvpn"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
