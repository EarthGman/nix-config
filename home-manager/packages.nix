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
        dua
    ];
}