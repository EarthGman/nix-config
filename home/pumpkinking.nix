{ self, outputs, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/pumpkinking/preferences.nix)
    outputs.homeProfiles.essentials
    outputs.homeProfiles.desktopThemes.hollow-knight
  ];
  programs.git = {
    userName = "PumpkinKing432";
    userEmail = "trombonekidd17@gmail.com";
  };
}
