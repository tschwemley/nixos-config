{ config, ... }:
let
  font_family = "Hasklug Nerd Font Mono";
  monitor = config.hyprland.monitors.primary;
in
{
  # TODO: clean up this file
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          inherit monitor;
          path = "/home/schwem/Pictures/wallpaper/2011-07-28_19-36-35_649.jpg";
        }
      ];

      input-field = [
        {
          inherit monitor;

          dots_center = true;
          dots_spacing = 0.2;
          fade_on_empty = false;
          outline_thickness = 1;
          size = "300, 50";

          # outer_color = "rgb(${c.primary})";
          # inner_color = "rgb(${c.on_primary_container})";
          # font_color = "rgb(${c.primary_container})";
          # monitor = "";
          # placeholder_text = ''<span font_family="${font_family}" foreground="##${c.primary_container}">Password...</span>'';
        }
      ];

      label = [
        {
          inherit font_family monitor;

          font_size = 50;
          halign = "center";
          position = "0, 150";
          text = "$TIME";
          valign = "center";

          # color = "rgb(${c.primary})";
          # monitor = "";
        }
        {
          inherit monitor font_family;

          font_size = 20;
          halign = "center";
          position = "0, 50";
          text = "cmd[update:3600000] date +'%a %b %d'";
          valign = "center";

          # color = "rgb(${c.primary})";
          # monitor = "";
        }
      ];
    };
  };
}
