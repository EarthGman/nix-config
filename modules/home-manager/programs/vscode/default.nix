{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault;
in
{
  programs.vscode = {
    enable =
      let
        cfg = config.custom.editor;
      in
      (
        cfg == "Codium" ||
        cfg == "codium" ||
        cfg == "Code" ||
        cfg == "code" ||
        cfg == "Vscode" ||
        cfg == "vscode"
      );
    package = mkDefault pkgs.master.vscodium-fhs;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    extensions = import ./extensions.nix { inherit pkgs; };
    userSettings = import ./settings.nix { inherit pkgs lib; };
  };
}
