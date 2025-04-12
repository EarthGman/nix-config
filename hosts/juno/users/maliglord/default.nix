{ pkgs, ... }:
let
  username = "maliglord";
in
{
  users.users.${username} = {
    hashedPassword = "$y$j9T$M4AGmiueZXQ0ZbxkIqNrk/$Ne63ZhKGeb7EB9PQ7l6OgA8rlxb.SSoOiN7q9qyDpf3";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
