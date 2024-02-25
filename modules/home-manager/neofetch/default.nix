{ pkgs, config, ... }:
let
  src = config.home.homeDirectory + "/src/nix-config";
  config_conf = src + "/modules/home-manager/neofetch/config.conf";
  logo = src + "/modules/home-manager/neofetch/nixos-logo.png";
in
{
  home = {
    file = {
      ".config/neofetch/config.conf".source = config.lib.file.mkOutOfStoreSymlink config_conf;
      ".config/neofetch/nixos-logo.png".source = config.lib.file.mkOutOfStoreSymlink logo;
    };
    packages = with pkgs; [
      neofetch # displays system info
      # required for displaying images in terminal
      imagemagick
      viu
    ];
  };
}
