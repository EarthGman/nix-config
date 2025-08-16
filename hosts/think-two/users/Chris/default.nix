{ pkgs, ... }:
{
  users.users.Chris = {
    isNormalUser = true;
    description = "Chris";
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$LkbSzX4yGKO9Ey2TM1Oq81$KK9l8.ZD2xq1JoeZkhNSHZI3Csj3eWUr8GT40hA6tT2";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
