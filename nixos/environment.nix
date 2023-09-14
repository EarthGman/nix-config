{config, pkgs, ...}:
{
  environment = {
    shells = [ pkgs.zsh ];
    variables = {
      EDITOR = "code";
    };
    systemPackages = with pkgs; [
      virt-manager
      git
      ripgrep
      eza
    ];  
  };
  programs.zsh.enable = true;
  programs._1password.enable = true;
  programs.dconf.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "g" ];
  };
  #services
  services.flatpak.enable = true;
  #enables clipboard sharing between host and guest for VMs
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.libvirtd.enable = true;
}
