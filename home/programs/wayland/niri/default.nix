{ self, ... }: {
  home.sessionVariables = {
    GDK_SCALE = 1.5;
  };

  wayland.windowManager.niri = {
    enable = true;
    package = self.inputs.niri.packages.x86_64-linux.default;

    settings = {
      binds = import ./binds.nix;
      environment = import ./environment.nix;
      input = import ./input.nix;

      # _children = [] ++ (import ./window-rules.nix);
      # _children = [ { gestures.hot-corners.enable = false; } ] ++ (import ./window-rules.nix);

      _children = (import ./window-rules.nix);

      gestures.hot-corners.off = { };

      # debug.disable-cursor-plane = true;
    };
  };
}
