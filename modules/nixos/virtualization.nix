#enables virtualization with qemu
{ pkgs, lib, ... }:
{
  boot.kernelModules = [ "kvm-intel" ];
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
  environment.systemPackages = with pkgs; [
    virt-manager
    qemu_kvm # virtual machines
  ];
  programs.dconf.enable = lib.mkDefault true;
}
