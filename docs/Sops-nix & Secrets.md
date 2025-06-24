If you want to store your nix flake in a public repository, you probably don't want your user's password or your public IP address sitting there in plain-text. That's why sops-nix exists, and with my NixOs configuration, it's pretty simple to set up.

------------------------------------------------------------------------
# Setup
You will need to obtain a age key pair.
you can obtain this on any system with "age" installed:

```
age-keygen -o key.txt
```

Take note of your public key and store your private key somewhere safe like a password vault.

Next in your flake project you will need to create a .sops.yaml in the root.  This will allow you to define rules to create and decrypt your secrets file.

Paste the following into .sops.yaml and change the fields.

```
keys:
  - &sops-key (your public age key goes here)

creation_rules:
  - path_regex: (relative path to a secrets.yaml)
    key_groups:
      - age:
        - *sops-key
```

# NixOS

Using mkHost you can specify a 'secretsFile' argument

```
nixos = lib.mkHost {
  hostName = "nixos";
  bios = "UEFI"; # double check which firmware your VM uses
  users = [ "bob" ];
  desktop = "gnome";
  vm = true;
  system = "x86_64-linux";
  stateVersion = "25.11";
  configDir = ./hosts/nixos;
  secretsFile = ./secrets.yaml;
};
```

This allows you to separate your secrets per host if you wish, or just keep them altogether, the choice is yours.

Next you will need to actually create the secrets.yaml file

ensure "sops" is installed on your system.
**Use an editor such as vim or nano, graphical editors do not work for this

```
EDITOR=vim sops secrets.yaml
```

and the editor should open the file.
Add secrets in yaml format. As an example we'll create a password for user bob.

In this example, I use mkpasswd and use "password" to generate a yescrypt hash.

```yaml
bob_password: $y$j9T$Dw4OWOMuCgek8aQzEniML1$Q0WWPuXP93Rc9iIdShDDYSUeSinQsFWGS0mrDFZVczA
```

Save the file, then exit. Try to cat secrets.yaml. It should be unreadable encrypted text

**In order to access the encrypted sops file you will need to have your private age key located at ~/.config/sops/age/keys.txt.

You can now access the file by running sops secrets.yaml to add or edit secrets.

next, to consume the example secret (which is a user password), somewhere in your hosts's nix modules you will need to add:

```
# this sets the bob_password.path to the correct place to be used by /etc/shadow
sops.secrets.bob_password.neededForUsers = true;
```

Now set bob's hashedPasswordFile to the secret

```
{ pkgs, config, ... }:
{
  users.users.bob = {
    isNormalUser = true; # must be set for non system users
    extraGroups = [ "wheel" ]; # allow sudo for this user
    shell = pkgs.zsh; # better than bash
    hashedPasswordFile = config.sops.secrets.bob_password.path; 
  };
}
```

In order to run nixos-rebuild or to install a fresh system, you will need to imperatively place the private key in the file defined by config.sops.age.keyFile. This defaults to "/var/lib/sops-nix/keys.txt" or ("/mnt/var/lib/sops-nix/keys.txt" when installing), but can be set to any path you wish.

**For security purposes ensure that this file is only accessible by root or sudo.
```
sudo chown root:root /var/lib/sops-nix/keys.txt
sudo chmod 600 /var/lib/sops-nix/keys.txt
```

# Home-manager

(untested, coming soon)