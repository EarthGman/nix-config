{ pkgs, lib, platform, users, hostname, ... }:
# template for modern UEFI desktop PCs
let
  usernames = builtins.filter builtins.isString (builtins.split "," users);
in
{
  imports = [
    ./services.nix
    ./grub.nix
    # imports each user assigned to a host under hosts/hostname/users
  ] ++ lib.forEach usernames (username: ../../hosts/${hostname}/users + /${username});

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    firewall = {
      checkReversePath = false;
      allowedTCPPorts = [
        22 # SSHD tellnet port
        443 # TLS/SSL listen port
        3389 # RDP port
      ];
      allowedUDPPorts = [
        1194 # openvpn listen port
        5353 # printer discovery port
      ];
    };
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };
  security.rtkit.enable = true;

  # macro stuff
  hardware.uinput.enable = true;
  users.groups = {
    uinput.members = usernames;
    input.members = usernames;
  };
}
