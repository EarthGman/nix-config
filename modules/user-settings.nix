 { pkgs, ... }:
 {
 users.users.g = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
      ];
    })
      firefox
    ];
  };
  programs.git = {
    enable = true;
    config = {
        user = {
            name = "g";
            email = "117403037+EarthGman@users.noreply.github.com";
        };
    };
  };
}