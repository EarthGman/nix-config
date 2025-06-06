{ pkgs, ... }:
{
  users.users."that1stranger" = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$b9HmtSmY./0mTh4zmxvRa1$zCo3.WxnkespNVSnRENF4cUetNLAfDFxljvx5XAEEU7";
  };
}
