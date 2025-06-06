{ pkgs, outputs, config, ... }:
{
  users.users."that1stranger" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    hashedPassword = "$j9T$JsNEAQUJEZM7Pcp39NzX/1$Fj18CwSSbqa./d6jE/tnv9lA5gXK.Ev0qXstUFF94s6";
  };
}
