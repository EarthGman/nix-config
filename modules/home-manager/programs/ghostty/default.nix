{ inputs, lib, platform, ... }:
{
  #latest version of ghostty
  programs.ghostty.package = lib.mkDefault inputs.ghostty.packages.${platform}.default;
}
