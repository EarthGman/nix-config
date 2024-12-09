{ pkgs, ... }:
{
  programs.brave = {
    # package = pkgs.brave;
    extensions = [
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock origin
    ];
  };
}
