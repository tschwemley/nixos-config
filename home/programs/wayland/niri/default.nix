{ lib, pkgs, ... }:
{
  # imports = [
  #   ../../../services/mako.nix
  #   ../../../services/wpaperd.nix
  # ];

  # home.sessionVariables.GDK_SCALE = 1.5;

  programs.niri = {
    # enable = true;
    package = pkgs.niri-unstable;
    settings = {
      binds = import ./binds.nix;

      debug.disable-cursor-plane = true;
      gestures.hot-corners.enable = false;

      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite;
      };
    };
  };
}
