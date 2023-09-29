{pkgs, ...}:
{
    home.packages = with pkgs; [
        gimp
        discord
        sysz
        prismlauncher
        grapejuice
        ncdu
        jq
        obsidian
        dconf
        dconf2nix
        dua
    ];
}
