{ pkgs, ... }:
let
  username = "iron";
in
{
  users.users.${username} = {
    hashedPassword = "$y$j9T$qRT7WQhojdi.uoI3tnn99.$CjgA/wZcn3kn3Z6MQuW7AbbUWJdIpHmDX9LczI6OLyA";
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
