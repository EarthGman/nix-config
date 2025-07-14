{ pkgs, ... }:
let
  inherit (pkgs) obsidianPlugins;
in
{
  programs.obsidian.defaultSettings.communityPlugins = [
    {
      pkg = obsidianPlugins.excalidraw;
    }
  ];
}
