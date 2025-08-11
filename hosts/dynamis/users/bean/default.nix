{
  pkgs,
  ...
}:
let
  username = "bean";
in
{
  users.users.${username} = {
    password = "123";
    # hashedPasswordFile =
    isNormalUser = true;
    description = username;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
