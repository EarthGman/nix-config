{ pkgs, ... }:
{
  breadcrumbs.enabled = false;
  files.autosave = "off";
  editor = {
    "cursorBlinking" = "smooth";
    "cursorWidth" = 2;
    "cursorSmoothCaretAnimation" = "on";
    "inlayHints.enabled" = false;
    "find.addExtraSpaceOnTop" = false;
    "fontSize" = 20;
    "fontFamily" = "'MesloLGS Nerd Font', monospace";
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
    "zoomLevel" = 0;

  };

  "extensions.ignoreRecommendations" = true;

  git = {
    "autofetch" = false;
    "confirmSync" = false;
    "enableSmartCommit" = true;
    "openRepositoryInParentFolders" = "always";
  };


  "terminal.integrated.smoothScrolling" = true;
  "terminal.integrated.cursorWidth" = 2;
  "terminal.integrated.cursorBlinking" = true;
  "terminal.integrated.fontSize" = 20;

  "debug.onTaskErrors" = "showErrors";

  nix = {
    "enableLanguageServer" = true;
    "formatterPath" = "${pkgs.alejandra}/bin/alejandra";
    "serverPath" = "${pkgs.nil}/bin/nil";
    "serverSettings"."nil"."formatting"."command" = [ "${pkgs.alejandra}/bin/alejandra" ];
  };
}

