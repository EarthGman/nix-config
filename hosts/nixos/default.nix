{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  users.users.root = {
    password = "123";
  };

  time.timeZone = "America/Chicago";
}
