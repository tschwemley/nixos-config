{
  pkgs,
  self,
  ...
}:
# Wayland config
{
  imports = [
    ./hyprland
  ];

  home.packages = with pkgs; [
    # screenshot
    grim
    slurp

    # utils
    # TODO: this looks kind of interesting... check to see if this is worth looking into copying
    # self.packages.${pkgs.system}.wl-ocr
    wl-clipboard
    wl-screenrec
    wlr-randr
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
