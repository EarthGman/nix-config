{ self, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/pumpkinking/preferences.nix)
    ./essentials.nix
  ];
  programs.git = {
    userName = "PumpkinKing432";
    userEmail = "trombonekidd17@gmail.com";
  };
}
