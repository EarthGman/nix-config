{ inputs, outputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };

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
}
