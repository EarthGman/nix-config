{ self, outputs, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/iron/preferences.nix)
    outputs.homeProfiles.essentials
  ];
  programs.git = {
    userName = "IronCutlass";
    userEmail = "nogreenink@gmail.com";
  };
}
