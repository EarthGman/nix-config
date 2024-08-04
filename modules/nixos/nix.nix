{ lib, outputs, platform, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    # gc = {
    #   automatic = true;
    #   options = "--delete-older-than 10d";
    # };
  };
  nixpkgs = {
    hostPlatform = lib.mkDefault platform;
    overlays = (builtins.attrValues outputs.overlays);
    config = {
      allowUnfree = true;
    };
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
}
