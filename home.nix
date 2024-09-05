{ self, username, config, hostName, pkgs, outputs, lib, stateVersion, ... }:
let
  inherit (lib) mkDefault mkOption types;
  programsDir = ./modules/home-manager/programs;
  programs = lib.forEach (builtins.attrNames (builtins.readDir programsDir)) (dirname: programsDir + /${dirname});
in
{
  imports = programs ++ [
    ./modules/home-manager/desktop-configs
    ./modules/home-manager/stylix
    ./templates/home-manager

    ./hosts/${hostName}/users/${username}/preferences.nix
  ];

  options.custom = {
    preferredEditor = mkOption {
      description = "string exported as EDITOR env variable";
      default = "nano";
      type = types.str;
    };
    terminal = mkOption {
      description = "which terminal emulator is used by default";
      default = "";
      type = types.str;
    };
  };

  config = {
    programs.home-manager.enable = true;

    home = {
      packages = [ pkgs.home-manager ];
      inherit username stateVersion;
      homeDirectory = "/home/${username}";
    };

    # enable gh for all users
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config.allowUnfree = true;
    };

    custom = {
      kitty.enable = mkDefault (config.custom.terminal == "kitty");
      vscode.enable = mkDefault (config.custom.preferredEditor == "codium");
      # zed.enable = mkDefault (editor == "zed");
    };
  };
}
