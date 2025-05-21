{ lib, config, modulesPath, ... }@args:
let
  vm = if args ? vm then args.vm else false;
  inherit (lib) mkIf mkEnableOption;
  cfg = config.profiles.qemu-guest;
  guest-profile =
    if vm then
      [ (modulesPath + "/profiles/qemu-guest.nix") ]
    else
      [ ];
in
{
  imports = guest-profile;
  options.profiles.qemu-guest.enable = mkEnableOption "qemu guest profile";
  config = mkIf cfg.enable {
    # nothing here yet
  };
}
