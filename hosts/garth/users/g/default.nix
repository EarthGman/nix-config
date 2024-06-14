{ pkgs, config, ... }:
{
  sops.secrets.g.neededForUsers = true;
  users.mutableUsers = false;

  users.users.g = {
    isNormalUser = true;
    description = "g";
    hashedPasswordFile = config.sops.secrets.g.path;
    packages = with pkgs; [ home-manager ];
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "nordvpn"
      "libvirtd"
      "qemu-libvirtd"
    ];
  };
}
