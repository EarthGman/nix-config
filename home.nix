# home-manager wrapper
{ outputs, config, lib, username, hostname, stateVersion, ... }:
{
  imports = [
    ./hosts/${hostname}/users/${username}/preferences.nix
    ./scripts
    ./modules/home-manager/apps
    ./modules/home-manager/browsers
    ./modules/home-manager/common
    ./modules/home-manager/desktop-configs
    ./modules/home-manager/editors
    ./modules/home-manager/gaming
    ./modules/home-manager/shells
    ./modules/home-manager/stylix
    ./modules/home-manager/terminals
    ./modules/home-manager/wine
  ];

  options.preferredEditor = lib.mkOption {
    description = "editor most apps will use to open files with by default";
    default = "code";
    type = lib.types.str;
  };
  config = {
    home = {
      inherit username;
      inherit stateVersion;
      homeDirectory = "/home/${username}";
    };
    programs.home-manager.enable = true;
    nixpkgs = {
      overlays = builtins.attrValues outputs.overlays;
      config = {
        allowUnfree = true;
      };
    };
  };
}
