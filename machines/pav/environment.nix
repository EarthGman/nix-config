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
  #services.nordvpn.enable = true;
  
  #enables virtualization
  virtualisation.libvirtd.enable = true;
}
