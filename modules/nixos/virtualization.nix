#enables virtualization with qemu
{ pkgs, lib, ... }:
{
  virtualisation = {
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
    virtiofsd
  ];
  programs.dconf.enable = lib.mkDefault true;
}
