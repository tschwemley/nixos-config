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

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    # TODO: remove or evaluate the tradeoffs of switching over to this. NOTE: it might be necessary
    # for some applications not using system implemenation of Qt (zoom is one of these)
    # QT_QPA_PLATFORM = "wayland;xcb";
    # SDL_VIDEODRIVER = "wayland;xcb";
    # see: https://wiki.archlinux.org/title/Wayland#GUI_libraries
  };
}
