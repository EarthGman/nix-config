{ lib, ... }:
{
  programs.ssh.askPassword = lib.mkForce "/nix/store/0dsjcbp33ibm4zkbhm99d3fxslnaj28v-seahorse-43.0/libexec/seahorse/ssh-askpass";
  # alternatively
  # programs.ssh.askPassword = lib.mkForce "/nix/store/0x5wr8fpppw3hbhrr0hbf0y5p6m0bwsg-ksshaskpass-6.0.5/bin/ksshaskpass"
}
