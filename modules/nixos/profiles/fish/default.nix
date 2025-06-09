{ self, pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.profiles.fish.default;
in
{
  options.profiles.fish.default.enable = mkEnableOption "default fish profile";
  config = mkIf cfg.enable {
    programs.fish = {
      vendor.completions.enable = true;
      shellAliases = import (self + "/modules/shared/shell-aliases.nix") { inherit pkgs lib config; };

      #   promptInit = mkIf config.programs.yazi.enable ''
      #      function y() {
      #      local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
      #      yazi "$argv" --cwd-file="$tmp"
      #      if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      #        builtin cd -- "$cwd"
      #      fi
      #      rm -f -- "$tmp"
      #     }
      #   '';
    };
  };
}
