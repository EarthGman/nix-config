{ pkgs, ... }:
{
  users.users.iron = {
    isNormalUser = true;
    description = "iron";
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$6/SLGD2ev./IeD8DFRFDA/$bGKe8j9QNRHdiwtzdMZm0lrUDDo7h//75hSHM84pNHD";
    extraGroups = [
      "wheel"
    ];
  };
}
