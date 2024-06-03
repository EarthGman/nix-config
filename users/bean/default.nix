{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
  };
  users.users.bean = {
    isNormalUser = true;
    description = "bean";
    shell = pkgs.zsh;
    # passwd = "";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
