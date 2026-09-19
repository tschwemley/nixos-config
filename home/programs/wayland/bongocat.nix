{ pkgs, ... }: {
  home.packages = [ pkgs.wayland-bongocat ];
  xdg.configFile."bongocat/bongocat".text = /* conf */ ''
    # Position & Size
    cat_height=80
    # cat_align=right
    cat_x_offset=700
    cat_y_offset=5
    overlay_opacity=0
    keyboard_name=Keyboardio Model 100
  '';
}
