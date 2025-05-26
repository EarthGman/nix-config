{ pkgs, lib, config, ... }:
let
  inherit (lib) mkDefault mkEnableOption getExe optionalString mkIf;
  cfg = config.programs;
in
{
  options.profiles.zsh.default.enable = mkEnableOption "zsh profie for nixos";
  config = mkIf config.profiles.zsh.default.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = mkDefault true;
      syntaxHighlighting.enable = mkDefault true;
      autosuggestions.enable = mkDefault true;
      shellAliases =
        let
          has-nh = config.programs.nh.enable;
          has-git = config.programs.git.enable;
        in
        {
          l = "ls -al";
          g = mkIf has-git "${getExe cfg.git.package}";
          t = "${getExe pkgs.tree}";
          lg = mkIf has-git "${getExe cfg.lazygit.package}";
          ga = mkIf has-git "g add .";
          gco = mkIf has-git "g checkout";
          gba = mkIf has-git "g branch -a";
          cat = mkIf (cfg.bat.enable) "${getExe cfg.bat.package}";
          nrs = if (has-nh) then "${getExe cfg.nh.package} os switch $(readlink -f /etc/nixos)" else "sudo nixos-rebuild switch --flake $(readlink -f /etc/nixos)";
          nrt = if (has-nh) then "${getExe cfg.nh.package} os test $(readlink -f /etc/nixos)" else "sudo nixos-rebuild test --flake $(readlink -f /etc/nixos)";
          nrb = "nixos-rebuild build";
          ncg = if (has-nh) then "${getExe cfg.nh.package} clean all" else "sudo nix-collect-garbage -d";
          nixos-update = "sudo nixos-rebuild switch --flake github:earthgman/nix-config";
        };

      promptInit = ''
        setopt autocd
      '' + optionalString (cfg.yazi.enable) ''
         function y() {
         local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
         yazi "$@" --cwd-file="$tmp"
         if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
           builtin cd -- "$cwd"
         fi
         rm -f -- "$tmp"
        }
      '';
    };
  };
}
