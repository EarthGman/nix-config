# caps lock = escape when tapped and META when held
{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(meta, esc)";
          };
        };
      };
    };
  };
}
