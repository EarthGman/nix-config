{
  self,
  inputs,
  lib,
  ...
}:
{
  nixos = lib.mkHost {
    hostName = "nixos";
    cpu = "intel";
    gpu = "intel";
    users = [ "bob" ];
    desktop = "sway";
    system = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./nixos;
    extraSpecialArgs = { inherit self inputs; };
  };

  # custom installer
  nixos-installer-x86_64 = lib.mkHost {
    hostName = "nixos-installer";
    system = "x86_64-linux";
    configDir = ./nixos-installer;
  };

  irons-laptop = lib.mkHost {
    hostName = "irons-laptop";
    cpu = "intel";
    gpu = "nvidia";
    users = [ "iron" ];
    desktop = "gnome";
    system = "x86_64-linux";
    configDir = ./irons-laptop;
    stateVersion = "25.11";
  };
}
