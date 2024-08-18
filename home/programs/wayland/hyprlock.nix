{inputs, config, pkgs, ...}: let
  font_family = "Hasklig";
in {
   programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          monitor = "";
          path = "/home/schwem/Pictures/wallpaper/2011-07-28_19-36-35_649.jpg";
        }
      ];

      input-field = [
        {
          monitor = config.hyprland.monitors.primary;

          size = "300, 50";

          outline_thickness = 1;

          # outer_color = "rgb(${c.primary})";
          # inner_color = "rgb(${c.on_primary_container})";
          # font_color = "rgb(${c.primary_container})";

          fade_on_empty = false;
          # placeholder_text = ''<span font_family="${font_family}" foreground="##${c.primary_container}">Password...</span>'';

          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 50;
          # color = "rgb(${c.primary})";

          position = "0, 150";

          valign = "center";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a %b %d'";
          inherit font_family;
          font_size = 20;
          # color = "rgb(${c.primary})";

          position = "0, 50";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
