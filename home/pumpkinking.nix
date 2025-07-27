{ self, hostName, ... }:
{
  imports = [
    (self + /hosts/${hostName}/users/pumpkinking/preferences.nix)
  ];

  custom.profiles.firefox = "shyfox";

  programs.git = {
    userName = "PumpkinKing432";
    userEmail = "trombonekidd17@gmail.com";
  };
}
