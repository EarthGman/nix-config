{ lib, ... }:
{
  meta.profiles = {
    # stylix = "spring-garden";
    firefox = "shyfox";
  };

  programs.vim.enable = lib.mkForce false;
  programs.neovim.enable = lib.mkForce false;

  gman = {
    rmpc.enable = true;
  };
  programs.freetube.enable = true;
}
