{ pkgs, keys, ... }:
{
  users.users.g = {
    isNormalUser = true;
    extraGroups = [ "wheel" "wireshark" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [ keys.g_pub ];
    hashedPassword = "$y$j9T$7tYxxNPgxLhrPDjHKj8nh/$8YcqgeeJMWnXGVP9VH0Tnzf/rkeWMZJ6VRZIWSEan94";
  };
}
