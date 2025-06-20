{ lib, ... }:
let
  inherit (lib) mkHost;
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
  };

  HP-G71340US = mkHost {
    hostName = "HP-G71340US";
    cpu = "intel";
    gpu = "intel";
    bios = "legacy";
    users = [ "that1stranger" ];
    desktop = "gnome";
    configDir = ./HP-G71340US;
  };

  # Thunder's desktops
  somnus = mkHost {
    hostName = "somnus";
    bios = "UEFI";
    cpu = "amd";
    gpu = "amd";
    users = [ "bean" ];
    desktop = "hyprland,i3,sway";
    secretsFile = ./somnus/secrets.yaml;
    stateVersion = "24.05";
    system = "x86_64-linux";
    configDir = ./somnus;
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
  };

  # pumpkin's desktops
  thePumpkinPatch = mkHost {
    hostName = "thePumpkinPatch";
    bios = "UEFI";
    cpu = "amd";
    gpu = "nvidia";
    users = [ "pumpkinking" ];
    desktop = "gnome";
    system = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./thePumpkinPatch;
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
