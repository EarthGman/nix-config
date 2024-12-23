{ self, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/iron/preferences.nix)
    ./essentials.nix
  ];
  programs.git = {
    userName = "IronCutlass";
    userEmail = "nogreenink@gmail.com";
  };
}
