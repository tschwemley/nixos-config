{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    name = "Posy_Cursor_Black";
    package = pkgs.posy-cursors;

    size = 32;
    x11.enable = true;

    hyprcursor = {
      enable = true;
      size = 32;
    };
  };
}
