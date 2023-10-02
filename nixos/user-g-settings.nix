 { pkgs, ... }:
 {
 users.users.g = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "qemu-libvirtd" ]; # Enable ‘sudo’ for the user.
  };
  programs.git = {
    enable = true;
    config = {
      user = {
          name = "g";
          email = "117403037+EarthGman@users.noreply.github.com";
      };
    };
  };
}
