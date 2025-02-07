{ lib, ... }:
let
  inherit (lib) mkHost;
in
{
  # Earth's desktops
  cypher = mkHost {
    hostName = "cypher";
    cpu = "amd";
    gpu = "amd";
    users = [ "g" ];
    desktop = "sway";
    platform = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./cypher;
  };

  garth = mkHost {
    hostName = "garth";
    cpu = "intel";
    gpu = "intel-igpu";
    users = [ "g" ];
    desktop = "sway";
    platform = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./garth;
  };

  tater = mkHost {
    hostName = "tater";
    cpu = "intel";
    gpu = "intel-igpu";
    users = [ "g" ];
    desktop = "sway";
    stateVersion = "25.05";
    configDir = ./tater;
  };

  nixos = mkHost {
    hostName = "nixos";
    vm = true;
    users = [ "test" ];
    desktop = "hyprland";
    platform = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./nixos;
  };

  # Thunder's desktops
  somnus = mkHost {
    hostName = "somnus";
    cpu = "amd";
    gpu = "amd";
    users = [ "bean" ];
    desktop = "hyprland,i3,sway";
    stateVersion = "24.05";
    platform = "x86_64-linux";
    configDir = ./somnus;
  };

  pioneer = mkHost {
    hostName = "pioneer";
    cpu = "intel";
    gpu = "intel-igpu";
    users = [ "bean" ];
    desktop = "sway";
    platform = "x86_64-linux";
    stateVersion = "24.11";
    configDir = ./pioneer;
  };

  # Iron's desktops
  petrichor = mkHost {
    hostName = "petrichor";
    cpu = "amd";
    gpu = "amd";
    users = [ "iron" ];
    desktop = "gnome";
    platform = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./petrichor;
  };

  # pumpkin's desktops
  thePumpkinPatch = mkHost {
    hostName = "thePumpkinPatch";
    cpu = "amd";
    gpu = "nvidia";
    users = [ "pumpkinking" ];
    desktop = "gnome";
    platform = "x86_64-linux";
    stateVersion = "24.05";
    configDir = ./thePumpkinPatch;
  };

  # servers
  mc112 = mkHost {
    hostName = "mc112";
    server = true;
    vm = true;
    platform = "x86_64-linux";
    stateVersion = "24.11";
    configDir = ./mc112;
  };

  mc-blueprints = mkHost {
    hostName = "mc-blueprints";
    server = true;
    vm = true;
    platform = "x86_64-linux";
    stateVersion = "24.11";
    configDir = ./mc-blueprints;
  };

  mc121 = mkHost {
    hostName = "mc121";
    server = true;
    vm = true;
    platform = "x86_64-linux";
    stateVersion = "24.11";
    configDir = ./mc121;
  };

  gman-theatre = mkHost {
    hostName = "gman-theatre";
    cpu = "intel";
    gpu = "amd";
    server = true;
    vm = false;
    platform = "x86_64-linux";
    stateVersion = "25.05";
    configDir = ./gman-theatre;
  };

  # isos
  installer-x86_64-without-firmware = mkHost {
    hostName = "nixos-installer";
    iso = true;
    platform = "x86_64-linux";
    configDir = ./iso/without-firmware;
  };

  installer-x86_64-with-firmware = mkHost {
    hostName = "nixos-installer";
    iso = true;
    platform = "x86_64-linux";
    configDir = ./iso/with-firmware;
  };
}
