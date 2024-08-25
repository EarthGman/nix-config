{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  "*" = {
    base00 = mkLiteral "#263238";
    base01 = mkLiteral "#2E3C43";
    base02 = mkLiteral "#314549";
    base03 = mkLiteral "#546E7A";
    base04 = mkLiteral "#B2CCD6";
    base05 = mkLiteral "#EEFFFF";
    base06 = mkLiteral "#EEFFFF";
    base07 = mkLiteral "#FFFFFF";
    base08 = mkLiteral "#F07178";
    base09 = mkLiteral "#F78C6C";
    base0A = mkLiteral "#FFCB6B";
    base0B = mkLiteral "#C3E88D";
    base0C = mkLiteral "#89DDFF";
    base0D = mkLiteral "#82AAFF";
    base0E = mkLiteral "#C792EA";
    base0F = mkLiteral "#FF5370";
    spacing = 0;
    background-color = mkLiteral "transparent";
  };

  "window" = {
    transparency = "real";
    background-color = mkLiteral "#263238FF";
  };

  "mainbox" = {
    children = map mkLiteral [ "inputbar" "message" "mode-switcher" "listview" ];
    spacing = mkLiteral "30px";
    padding = mkLiteral "30px 0";
    border = mkLiteral "1px";
    border-color = mkLiteral "@base0D";
  };

  "inputbar" = {
    padding = mkLiteral "0 30px";
    children = map mkLiteral [ "prompt" "textbox-prompt-colon" "entry" "case-indicator" ];
  };

  "prompt" = {
    text-color = mkLiteral "@base0D";
  };

  "textbox-prompt-colon" = {
    expand = false;
    str = ":";
    margin = mkLiteral "0 1ch 0 0";
    text-color = mkLiteral "@base0D";
  };

  "entry" = {
    text-color = mkLiteral "@base07";
  };

  "case-indicator" = {
    text-color = mkLiteral "@base0F";
  };

  "mode-switcher, message" = {
    border = mkLiteral "1px 0";
    border-color = mkLiteral "@base0D";
  };

  "button selected" = {
    background-color = mkLiteral "@base0D";
  };

  "listview" = {
    scrollbar = true;
    margin = mkLiteral "0 10px 0 30px";
  };

  "scrollbar" = {
    background-color = mkLiteral "@base03";
    handle-color = mkLiteral "@base0D";
    handle-width = mkLiteral "10px";
    border = mkLiteral "0 1px";
    border-color = mkLiteral "@base0D";
    margin = mkLiteral "0 0 0 20px";
  };

  "element" = {
    padding = mkLiteral "5px";
    spacing = mkLiteral "5px";
    highlight = mkLiteral "bold underline";
    children = map mkLiteral [ "element-icon" "element-text" ];
  };

  "element-text, element-icon" = {
    background-color = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
    foreground-color = mkLiteral "inherit";
  };

  "element normal" = {
    background-color = mkLiteral "transparent";
  };

  "element selected" = {
    background-color = mkLiteral "@base0D";
  };

  # "#element-alternate" = {

  # };

  "element normal normal, element selected normal, element alternate normal" = {
    text-color = mkLiteral "@base07";
  };

  "element normal urgent, element selected urgent, element alternate urgent" = {
    text-color = mkLiteral "@base0F";
  };

  "element normal active, element selected active, element alternate active" = {
    text-color = mkLiteral "@base0B";
  };
}
