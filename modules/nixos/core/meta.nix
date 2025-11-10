{ lib, ... }:
{
  options.meta = {
    bios = lib.mkOption {
      description = "x86 firmware implementation";
      type = lib.types.str;
      default = "UEFI";
      example = "legacy";
    };

    cpu = lib.mkOption {
      description = "x86 cpu brand";
      type = lib.types.str;
      default = "intel";
      example = "amd";
    };

    gpu = lib.mkOption {
      description = "x86 gpu brand";
      type = lib.types.str;
      default = "";
      example = "nvidia";
    };

    users = lib.mkOption {
      description = "list of users that will recieve a home-manager configuration";
      type = lib.types.listOf lib.types.str;
      default = [ ];
      example = [
        "bob"
        "alice"
      ];
    };

    vm = lib.mkOption {
      description = "whether this host is a qemu virtual machine";
      type = lib.types.bool;
      default = false;
    };

    server = lib.mkOption {
      description = "whether this host is a server";
      type = lib.types.bool;
      default = false;
    };

    profiles = {
      sddm = lib.mkOption {
        description = "sddm profile to use";
        type = lib.types.str;
        default = "";
      };
    };
  };
}
