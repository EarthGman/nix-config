{ config, lib, ... }:
{
  programs.fd = {
    enable = lib.mkDefault config.programs.fzf.enable;
    ignores = [
      ".git/"
      ".bak"
      ".direnv/"
    ];
  };
}
