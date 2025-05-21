{ self, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/pumpkinking/preferences.nix)
  ];

  profiles.essentials.enable = true;

  programs.git = {
    userName = "PumpkinKing432";
    userEmail = "trombonekidd17@gmail.com";
  };
}
