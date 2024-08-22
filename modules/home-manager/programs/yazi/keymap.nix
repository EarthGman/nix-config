{ pkgs, ... }:
{
  manager = {
    prepend_keymap = [
      {
        on = "<C-A-c>";
        run = "${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i \"$1\"";
        desc = "copy screenshot to clipboard";
      }
    ];
  };
}
