{
  imports = [ ./disko.nix ];
  profiles.essentials.enable = true;

  zramSwap.enable = true;
}
