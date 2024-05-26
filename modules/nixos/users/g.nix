{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
    _1password-gui.polkitPolicyOwners = [ "g" ];
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
