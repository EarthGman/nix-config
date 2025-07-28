{
  self,
  inputs,
  outputs,
  lib,
  ...
}:
let
  inherit (lib) mkHost;
  keys = import ../keys.nix;
in
{
  # Earth's desktops
  # custom built gaming desktop and workstation
  cypher = mkHost {
    hostName = "cypher";
    bios = "UEFI";
    cpu = "amd";
    gpu = "amd";
    users = [ "g" ];
    desktop = "sway";
    secretsFile = ./cypher/secrets.yaml;
    system = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./cypher;
    extraSpecialArgs = {
      inherit
        self
        inputs
        outputs
        keys
        ;
    };
  };

  # Corebooted Thinkpad x230
  twilight = mkHost {
    hostName = "twilight";
    bios = "legacy";
    cpu = "intel";
    gpu = "intel";
    users = [ "g" ];
    desktop = "hyprland";
    secretsFile = ./twilight/secrets.yaml;
    system = "x86_64-linux";
    configDir = ./twilight;
    extraSpecialArgs = {
      inherit
        self
        inputs
        outputs
        keys
        ;
    };
  };

  # still working HP pavilion x360 potato
  tater = mkHost {
    hostName = "tater";
    bios = "UEFI";
    cpu = "intel";
    gpu = "intel";
    users = [ "g" ];
    desktop = "sway";
    secretsFile = ./tater/secrets.yaml;
    system = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./tater;
    extraSpecialArgs = {
      inherit
        self
        inputs
        outputs
        keys
        ;
    };
  };

  HP-G71340US = mkHost {
    hostName = "HP-G71340US";
    cpu = "intel";
    gpu = "intel";
    bios = "legacy";
    users = [ "that1stranger" ];
    desktop = "gnome";
    configDir = ./HP-G71340US;
    extraSpecialArgs = { inherit self inputs outputs; };
  };

  # Thunder's desktops
  dynamis = mkHost {
    hostName = "dynamis";
    bios = "UEFI";
    cpu = "amd";
    gpu = "amd";
    users = [ "bean" ];
    desktop = "hyprland";
    system = "x86_64-linux";
    configDir = ./dynamis;
    extraSpecialArgs = { inherit self inputs; };
  };

  somnus = mkHost {
    hostName = "somnus";
    bios = "UEFI";
    cpu = "amd";
    gpu = "nvidia";
    users = [ "bean" ];
    desktop = "gnome";
    secretsFile = ./somnus/secrets.yaml;
    stateVersion = "24.05";
    system = "x86_64-linux";
    configDir = ./somnus;
    extraSpecialArgs = { inherit self inputs outputs; };
  };

  pioneer = mkHost {
    hostName = "pioneer";
    bios = "UEFI";
    cpu = "intel";
    gpu = "intel";
    users = [ "bean" ];
    desktop = "sway";
    system = "x86_64-linux";
    stateVersion = "24.11";
    configDir = ./pioneer;
    extraSpecialArgs = { inherit self inputs outputs; };
  };

  # Iron's desktops
  petrichor = mkHost {
    hostName = "petrichor";
    bios = "UEFI";
    cpu = "amd";
    gpu = "amd";
    users = [ "iron" ];
    desktop = "gnome";
    system = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./petrichor;
    extraSpecialArgs = { inherit self inputs outputs; };
  };

  # pumpkin's desktops
  thePumpkinPatch = mkHost {
    hostName = "thePumpkinPatch";
    bios = "UEFI";
    cpu = "intel";
    gpu = "nvidia";
    users = [ "pumpkinking" ];
    desktop = "i3";
    system = "x86_64-linux";
    stateVersion = "25.11";
    configDir = ./thePumpkinPatch;
    extraSpecialArgs = { inherit self inputs outputs; };
  };

  juno = mkHost {
    hostName = "juno";
    bios = "UEFI";
    cpu = "amd";
    gpu = "amd";
    users = [ "maliglord" ];
    desktop = "gnome";
    system = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./juno;
    extraSpecialArgs = { inherit self inputs outputs; };
  };

  gman-theatre = mkHost {
    hostName = "gman-theatre";
    cpu = "intel";
    gpu = "amd";
    server = true;
    vm = false;
    secretsFile = ./gman-theatre/secrets.yaml;
    system = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./gman-theatre;
    extraSpecialArgs = {
      inherit
        self
        inputs
        outputs
        keys
        ;
    };
  };

  # isos
  installer-x86_64-without-firmware = mkHost {
    hostName = "nixos-installer";
    iso = true;
    system = "x86_64-linux";
    configDir = ./iso/without-firmware;
  };

  installer-x86_64-with-firmware = mkHost {
    hostName = "nixos-installer";
    iso = true;
    system = "x86_64-linux";
    configDir = ./iso/with-firmware;
  };
}
