{ pkgs, config, lib, ... }:
let
  src = config.home.homeDirectory + "/src/nix-config";
  config_conf = src + "/modules/home-manager/common/neofetch/config.conf";
  logo = src + "/modules/home-manager/common/neofetch/nixos-logo.png";
in
{
  options.neofetch.enable = lib.mkEnableOption "enable neofetch";
  config = lib.mkIf config.neofetch.enable {
    home = {
      file = {
        ".config/neofetch/config.conf".source = config.lib.file.mkOutOfStoreSymlink config_conf;
        ".config/neofetch/nixos-logo.png".source = config.lib.file.mkOutOfStoreSymlink logo;
      };
      packages = with pkgs; [
        neofetch
        # required for displaying images in terminal
        imagemagick
        viu
      ];
    };
  };
}
