{ inputs, outputs, mylib, ... }:
{
  packages = final: _prev: import ../pkgs { pkgs = final; inherit mylib; };

  nur = inputs.nur.overlay;

  nixpkgs-unstable = final: _: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
  nixpkgs-master = final: _: {
    master = import inputs.nixpkgs-master {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  # gtk portal is not used in i3 by default
  xdg-desktop-portal-gtk = final: prev: {
    xdg-desktop-portal-gtk = (prev.xdg-desktop-portal-gtk.overrideAttrs {
      postInstall = ''
        sed -i 's/UseIn=gnome/UseIn=gnome;none+i3/' $out/share/xdg-desktop-portal/portals/gtk.portal
      '';
    }).override {
      buildPortalsInGnome = false;
    };
  };

  xdg-desktop-portal-gnome = final: prev: {
    xdg-desktop-portal-gnome = (prev.xdg-desktop-portal-gnome.overrideAttrs {
      postInstall = ''
        sed -i 's/UseIn=gnome/UseIn=gnome;none+i3/' $out/share/xdg-desktop-portal/portals/gnome.portal
      '';
    });
  };

  # required for OpenCL detection within davinci-resolve for AMD graphics cards
  davinci-resolve = final: prev: {
    davinci-resolve = prev.davinci-resolve.override (old: {
      buildFHSEnv = a: (old.buildFHSEnv (a // {
        extraBwrapArgs = a.extraBwrapArgs ++ [
          "--bind /run/opengl-driver/etc/OpenCL /etc/OpenCL"
        ];
      }));
    });
  };

  disable-mbrola-voices = final: prev: {
    espeak = prev.espeak.override {
      mbrolaSupport = false;
    };
  };
}
