{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
in
{
  preferredEditor = mkDefault "codium";
  custom = {
    kitty.enable = mkDefault true;
    zsh.enable = mkDefault true;
    # firefox.enable = mkDefault true;
    # fastfetch.enable = mkDefault true;
    # mupdf.enable = mkDefault true;
    # switcheroo.enable = mkDefault true;
    vscode.enable = (config.preferredEditor == "codium");
    # zed.enable = mkDefault (editor == "zed");
  };
  gtk = {
    enable = true;
    iconTheme = mkDefault {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
