{
  self,
  hostName,
  ...
}:
{
  imports = [
    (self + /hosts/${hostName}/users/iron/preferences.nix)
  ];

  profiles.essentials.enable = true;

  custom.profiles.firefox = "shyfox";

  programs.git = {
    userName = "IronCutlass";
    userEmail = "nogreenink@gmail.com";
  };
}
