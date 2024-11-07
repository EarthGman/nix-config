{ cpu, pkgs, lib, config, ... }:
let
  cfg = config.modules.qemu-kvm;
in
{
  options.modules.qemu-kvm.enable = lib.mkEnableOption "enable virtual machines using qemu-kvm";
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
    boot.kernelModules = [ "kvm-${cpu}" ];
    environment.systemPackages = with pkgs; [
      qemu_kvm
      virtiofsd # file system sharing with VMs
    ];
  };
}
