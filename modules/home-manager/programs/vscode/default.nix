{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption mkIf;
in
{
  options.vscode.enable = mkEnableOption "enable vscode";
  config = mkIf config.vscode.enable {

    programs.vscode = {
      package = mkDefault pkgs.master.vscodium-fhs;
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.master.vscode-extensions; [
        # nix
        bbenoist.nix
        jnoortheen.nix-ide
        b4dm4n.vscode-nixpkgs-fmt

        # cpp
        ms-vscode.cpptools
        ms-vscode.cmake-tools

        # python
        ms-python.vscode-pylance

        # lua
        sumneko.lua

        #rust
        rust-lang.rust-analyzer

        # utilities
        naumovs.color-highlight
        vscode-icons-team.vscode-icons
        tomoki1207.pdf
        ms-vscode-remote.remote-ssh
      ];

      userSettings = {
        breadcrumbs.enabled = false;
        files.autosave = "off";
        editor = {
          "cursorBlinking" = "smooth";
          "cursorWidth" = 2;
          "cursorSmoothCaretAnimation" = "on";
          "inlayHints.enabled" = false;
          "find.addExtraSpaceOnTop" = false;
          "fontSize" = 20;
          "fontFamily" = "'SauceCodePro Nerd Font', 'monospace'";
          "largeFileOptimizations" = false;
          "maxTokenizationLineLength" = 60000;
          "linkedEditing" = true;
          "overviewRulerBorder" = false;
          "renderWhitespace" = "none";
          "bracketPairColorization.independentColorPoolPerBracketType" = true;
          "tabSize" = 2;
          "formatOnSave" = true;
          "suggest.showIcons" = false;
          "minimap.enabled" = false;
          "defaultFormatter" = "B4dM4n.nixpkgs-fmt";
        };
        # doesn't work when placed in the editor block?
        "editor.guides.bracketPairs" = true;

        workbench = {
          "iconTheme" = "vscode-icons";
          "colorTheme" = "Default High Contrast";
        };

        "security.workspace.trust.enabled" = false;

        window = {
          "dialog.Style" = "custom";
          "titleBarStyle" = "custom";
          "zoomLevel" = -1;

        };

        "extensions.ignoreRecommendations" = true;

        git = {
          "autofetch" = false;
          "confirmSync" = false;
          "enableSmartCommit" = true;
          "openRepositoryInParentFolders" = "always";
        };

        terminal = {
          "integrated.smoothScrolling" = true;
          "integrated.cursorWidth" = 2;
          "integrated.cursorBlinking" = true;
          "integrated.fontSize" = 16;

        };

        "debug.onTaskErrors" = "showErrors";

        nix = {
          "enableLanguageServer" = true;
          "formatterPath" = "${pkgs.alejandra}/bin/alejandra";
          "serverPath" = "${pkgs.nil}/bin/nil";
          "serverSettings"."nil"."formatting"."command" = [ "${pkgs.alejandra}/bin/alejandra" ];
        };
      };
    };
  };
}
