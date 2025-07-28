{
  pkgs,
  lib,
  config,
  ...
}@args:
let
  cfg = config.modules.qemu-kvm;
  cpu = if args ? cpu then args.cpu else "";
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
    boot.kernelModules = lib.mkIf (cpu != "") [ "kvm-${cpu}" ];
    environment.systemPackages = with pkgs; [
      qemu_kvm
      virtiofsd # file system sharing with VMs
    ];
  };
}
