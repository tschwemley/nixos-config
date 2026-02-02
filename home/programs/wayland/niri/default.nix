{
  imports = [ ../../../services/mako.nix ];

  # creates xdg.configFile.<name>.source entries for the strings in the list.
  config.xdg.configFile = builtins.listToAttrs (
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
