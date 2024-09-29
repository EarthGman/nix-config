{ pkgs, ... }:
let
  ssh-key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKNRHd6NLt4Yd9y5Enu54fJ/a2VCrRgbvfMuom3zn5zg";
in
{
  users.users.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ ssh-key ];
    hashedPassword = "$y$j9T$7tYxxNPgxLhrPDjHKj8nh/$8YcqgeeJMWnXGVP9VH0Tnzf/rkeWMZJ6VRZIWSEan94";
  };
}
