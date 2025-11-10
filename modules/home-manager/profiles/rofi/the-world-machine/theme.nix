{ config, ... }:
let
  inherit (config.lib.formats.rasi) mkLiteral;
in
{
  "*" = {
    background-color = mkLiteral "transparent";
    border-color = mkLiteral "var(foreground)";
    background = mkLiteral "rgba (0, 0, 0, 100 %)";
    foreground = mkLiteral "rgba ( 208, 208, 208, 100 %)";
  };

  element = {
    padding = mkLiteral "1px";
    cursor = mkLiteral "pointer";
    orientation = mkLiteral "vertical";
    spacing = mkLiteral "5px";
    border = mkLiteral "0";
  };

  "element selected" = {
    background-color = mkLiteral "rgb(32, 32, 32)";
  };

  element-text = {
    cursor = mkLiteral "inherit";
    highlight = mkLiteral "inherit";
    text-color = mkLiteral "rgb(149, 100, 253)";
    vertical-align = mkLiteral "1";
    horizontal-align = mkLiteral "0.5";
    border = mkLiteral "0";
  };

  element-icon = {
    size = mkLiteral "2.25em";
    cursor = mkLiteral "inherit";
    text-color = mkLiteral "inherit";
  };

  window = {
    padding = mkLiteral "3";
    background-color = mkLiteral "var(background)";
    border = mkLiteral "4";
  };

  mainbox = {
    padding = mkLiteral "0";
    border = mkLiteral "0";
  };

  message = {
    padding = mkLiteral "1px";
    border-color = mkLiteral "var(foreground)";
    border = mkLiteral "2px dash 0px 0px";
  };

  textbox = {
    text-color = mkLiteral "var(foreground)";
  };

  listview = {
    padding = mkLiteral "25px 50px 150px";
    scrollbar = mkLiteral "true";
    border-color = mkLiteral "var(foreground)";
    spacing = mkLiteral "100px";
    fixed-height = mkLiteral "1";
    border = mkLiteral "10px solid 0px 0px";
    lines = mkLiteral "2";
    columns = mkLiteral "4";
    layout = mkLiteral "vertical";
  };

  num-filtered-rows = {
    expand = mkLiteral "false";
    text-color = mkLiteral "Gray";
  };

  num-rows = {
    expand = mkLiteral "false";
    text-color = mkLiteral "Gray";
  };

  textbox-num-sep = {
    expand = mkLiteral "false";
    str = "/";
    text-color = mkLiteral "Gray";
  };

  inputbar = {
    padding = mkLiteral "1px";
    spacing = mkLiteral "0px";
    text-color = mkLiteral "var(foreground)";
    children = map mkLiteral [
      "prompt"
      "textbox-prompt-colon"
      "entry"
      "overlay"
      "num-filtered-rows"
      "textbox-num-sep"
      "num-rows"
      "case-indicator"
    ];
  };

  overlay = {
    padding = mkLiteral "0px 0.2000em";
    background-color = mkLiteral "var(foreground)";
    foreground-color = mkLiteral "var(background)";
    margin = mkLiteral "0px 0.2000em";
    text-color = mkLiteral "var(background)";
  };

  case-indicator = {
    spacing = mkLiteral "0";
    text-color = mkLiteral "var(foreground)";
  };

  entry = {
    text-color = mkLiteral "var(foreground)";
    cursor = mkLiteral "text";
    spacing = mkLiteral "0";
    placeholder-color = mkLiteral "Gray";
    placeholder = "";
  };

  prompt = {
    spacing = mkLiteral "0";
    text-color = mkLiteral "var(foreground)";
  };

  textbox-prompt-colon = {
    margin = mkLiteral "0px 0.3000em 0.0000em 0.0000em";
    expand = mkLiteral "false";
    str = ":";
    text-color = mkLiteral "inherit";
  };
}
