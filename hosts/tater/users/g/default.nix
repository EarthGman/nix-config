{ pkgs, ... }:
{
  users.users.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$7tYxxNPgxLhrPDjHKj8nh/$8YcqgeeJMWnXGVP9VH0Tnzf/rkeWMZJ6VRZIWSEan94";
  };
}
