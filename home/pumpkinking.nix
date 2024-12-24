{ self, outputs, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/pumpkinking/preferences.nix)
    outputs.homeProfiles.essentials
  ];
  programs.git = {
    userName = "PumpkinKing432";
    userEmail = "trombonekidd17@gmail.com";
  };
}
