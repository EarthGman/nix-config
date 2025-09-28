{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.gman.qemu-kvm;
in
{
  # If you dont want libvirtd to requre sudo, add your user to the "libvirtd" group
  options.gman.qemu-kvm.enable = lib.mkEnableOption "gman's qemu configuration";
  config = lib.mkIf cfg.enable {
    virtualisation = {
      spiceUSBRedirection.enable = true;
      libvirtd = {
        enable = true;
        qemu = {
          ovmf = {
            # UEFI firmware
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
          swtpm.enable = true;
          package = pkgs.qemu_kvm;
        };
      };
    };
    programs.virt-manager.enable = true;
    boot.kernelModules = lib.mkIf (config.meta.cpu != "") [ "kvm-${config.meta.cpu}" ];
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs)
        virtiofsd # file system sharing with VMs
        ;
    };
  };
}
