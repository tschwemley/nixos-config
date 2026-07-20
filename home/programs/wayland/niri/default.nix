{
  self,
  lib,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    # GDK_SCALE = 1.5;
    # QT_QPA_PLATFORM = "wayland";
  };

  programs.niri = {
    package = pkgs.niri-unstable;

    # REF: https://github.com/sodiboo/niri-flake
    settings = {
      binds = import ./binds.nix;
      environment = import ./environment.nix;
      input = import ./input.nix;
      window-rules = import ./window-rules.nix;

      # debug.disable-cursor-plane = true;
      gestures.hot-corners.enable = false;

      xwayland-satellite = {
        enable = true;
        path = lib.getExe pkgs.xwayland-satellite;
      };
    };
  };
}
