#enables virtualization with qemu
{ pkgs, lib, ... }:
{
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
        swtpm.enable = true;
        package = pkgs.qemu_kvm;
      };
    };
  };
  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    qemu_kvm # virtual machines
    virtiofsd # file system sharing with VMs
  ];
  programs.dconf.enable = lib.mkDefault true;
}
