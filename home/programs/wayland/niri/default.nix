{
  imports = [
    ../../../services/mako.nix
    ../../../services/wpaperd.nix
  ];

  home.sessionVariables.GDK_SCALE = 1.5;

  # creates xdg.configFile.<name>.source entries for the strings in the list.
  xdg.configFile = builtins.listToAttrs (
    map
      (name: {
        name = "niri/${name}.kdl";
        value = {
          source = ./. + "/${name}.kdl";
        };
      })
      [
        "binds"
        "config"
        "layout"
        "input"
        "window-rules"
      ]
  );
}
