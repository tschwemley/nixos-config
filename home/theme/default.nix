{ pkgs, ... }:
{
  home.pointerCursor = {
    # package = pkgs.bibata-cursors;
    # name = "Bibata-Modern-Classic";

    package = pkgs.volantes-cursors;
    name = "Volantes Cursors";
    size = 32;
    gtk.enable = true;
    hyprcursor.enable = true;
    x11.enable = true;
  };
}
