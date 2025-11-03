{
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
    specialization = "gaming";
    desktop = "hyprland";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./cypher;
    extraSpecialArgs = { inherit inputs; };
    secretsFile = ./cypher/secrets.yaml;
  };

  # corebooted thinkpad x230, main laptop
  think-one = lib.mkHost {
    hostname = "think-one";
    bios = "legacy";
    cpu = "intel";
    gpu = "intel";
    desktop = "hyprland";
    specialization = "none";
    system = "x86_64-linux";
    stateVersion = "25.11";
    secretsFile = ./think-one/secrets.yaml;
    configDir = ./think-one;
    extraSpecialArgs = { inherit inputs; };
  };

  # dad's thinkpad t480
  think-two = lib.mkHost {
    hostname = "think-two";
    cpu = "intel";
    gpu = "intel";
    desktop = "plasma";
    system = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./think-two;
    extraSpecialArgs = { inherit inputs; };
  };

  # thunder's gaming pc with jovin-nixos
  dynamis = lib.mkHost {
    hostname = "dynamis";
    cpu = "amd";
    gpu = "amd";
    desktop = "hyprland";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./dynamis;
    extraSpecialArgs = { inherit inputs; };
  };

  # thunder's old gaming pc
  somnus = lib.mkHost {
    hostname = "somnus";
    cpu = "amd";
    gpu = "amd";
    desktop = "plasma";
    system = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./somnus;
    secretsFile = ./somnus/secrets.yaml;
  };

  # thunder's old HP craptop
  pioneer = lib.mkHost {
    hostname = "pioneer";
    cpu = "intel";
    gpu = "intel";
    desktop = "sway";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./pioneer;
  };

  # pumpkin's gaming pc
  pumpkin-patch = lib.mkHost {
    hostname = "pumpkin-patch";
    cpu = "intel";
    gpu = "nvidia";
    desktop = "hyprland";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./pumpkin-patch;
  };

  # self explanitory
  irons-laptop = lib.mkHost {
    hostname = "irons-laptop";
    cpu = "intel";
    gpu = "nvidia";
    desktop = "plasma";
    system = "x86_64-linux";
    configDir = ./irons-laptop;
    stateVersion = "25.11";
  };

  # custom installer
  nixos-installer-x86_64 = lib.mkHost {
    hostname = "nixos-installer";
    system = "x86_64-linux";
    configDir = ./nixos-installer;
    extraSpecialArgs = { inherit inputs; };
  };

  # test vm for install.sh and other
  nixos = lib.mkHost {
    hostname = "nixos";
    bios = "legacy";
    vm = true;
    desktop = "plasma";
    configDir = ./nixos;
    stateVersion = "25.11";
    system = "x86_64-linux";
  };

  # thunder's 2013 intel macbook
  eve = lib.mkHost {
    hostname = "eve";
    stateVersion = "25.11";
    system = "x86_64-linux";
    cpu = "intel";
    gpu = "intel";
    desktop = "hyprland";
    configDir = ./eve;
  };
}
