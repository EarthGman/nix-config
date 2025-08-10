{
  self,
  inputs,
  lib,
  ...
}:
{
  # custom built gaming desktop and workstation
  cypher = lib.mkHost {
    hostname = "cypher";
    cpu = "amd";
    gpu = "amd";
    users = [ "g" ];
    desktop = "sway";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./cypher;
    extraSpecialArgs = { inherit inputs; };
    secretsFile = ./cypher/secrets.yaml;
  };

  think-one = lib.mkHost {
    hostname = "think-one";
    bios = "legacy";
    cpu = "intel";
    gpu = "intel";
    users = [ "g" ];
    desktop = "hyprland";
    system = "x86_64-linux";
    stateVersion = "25.11";
    secretsFile = ./think-one/secrets.yaml;
    configDir = ./think-one;
    extraSpecialArgs = { inherit inputs; };
  };

  think-two = lib.mkHost {
    hostname = "think-two";
    cpu = "intel";
    gpu = "intel";
    users = [ "bob" ];
    desktop = "sway";
    system = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./think-two;
    extraSpecialArgs = { inherit inputs; };
  };

  irons-laptop = lib.mkHost {
    hostname = "irons-laptop";
    cpu = "intel";
    gpu = "nvidia";
    users = [ "iron" ];
    desktop = "gnome";
    system = "x86_64-linux";
    configDir = ./irons-laptop;
    stateVersion = "25.11";
  };

  # custom installer
  nixos-installer-x86_64 = lib.mkHost {
    hostname = "nixos-installer";
    system = "x86_64-linux";
    configDir = ./nixos-installer;
  };
}
