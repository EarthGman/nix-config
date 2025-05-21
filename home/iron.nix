{ self, outputs, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/iron/preferences.nix)
  ];

  profiles.essentials.enable = true;

  programs.git = {
    userName = "IronCutlass";
    userEmail = "nogreenink@gmail.com";
  };
}
