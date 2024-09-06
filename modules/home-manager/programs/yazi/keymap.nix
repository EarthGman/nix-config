{ pkgs, ... }:
{
  manager = {
    prepend_keymap = [
      {
        on = "<C-A-c>";
        run = "shell '${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i \"$@\"' --confirm";
        desc = "copy screenshot to clipboard";
      }
    ];
  };
}
