{ lib, ... }:
{
  options.gman.ssh-keys = lib.mkOption {
    description = "public ssh keys for ease of access";
    type = lib.types.attrsOf lib.types.str;
    default = {
      g = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
    };
  };
}
