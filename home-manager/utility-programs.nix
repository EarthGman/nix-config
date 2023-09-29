{ pkgs , ... }:
{
    programs = {
        zsh.enable = true;
        bat.enable = true;
        htop.enable = true;
        direnv.enable = true;
        direnv.nix-direnv.enable = true;
        zoxide = {
            enable = true;
            enableZshIntegration = true;
            options = [ "--cmd" "j" ];
        };
    };
}
