{
  services.dunst = {
    enable = true;

    settings = {
      # global = {
      # monitor = 0;
      # follow = "none";
      # width = 300; # TOML has `width = 300`, not the commented (0, 300)
      # height = 300;
      # origin = "top-right";
      # offset = "10,50"; # TOML has `offset = (10, 50)`
      # scale = 0;
      # notification_limit = 20;
      # progress_bar = true;
      # progress_bar_height = 10;
      # progress_bar_frame_width = 1;
      # progress_bar_min_width = 150;
      # progress_bar_max_width = 300;
      # progress_bar_corner_radius = 0;
      # progress_bar_corners = "all";
      # icon_corner_radius = 0;
      # icon_corners = "all";
      # indicate_hidden = true; # TOML 'yes'
      # transparency = 0;
      # separator_height = 2;
      # padding = 8;
      # horizontal_padding = 8;
      # text_icon_padding = 0;
      # frame_width = 3;
      # frame_color = "#aaaaaa";
      # gap_size = 0;
      # separator_color = "frame";
      # sort = true; # TOML 'yes'
      # font = "Monospace 8";
      # line_height = 0;
      # markup = "full";
      # format = "<b>%s</b>\n%b";
      # alignment = "left";
      # vertical_alignment = "center";
      # show_age_threshold = 60;
      # ellipsize = "middle";
      # ignore_newline = false; # TOML 'no'
      # stack_duplicates = true;
      # hide_duplicate_count = false;
      # show_indicators = true; # TOML 'yes'
      # enable_recursive_icon_lookup = true;
      # icon_theme = "Adwaita";
      # icon_position = "left";
      # min_icon_size = 32;
      # max_icon_size = 128;
      # icon_path = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
      # sticky_history = true; # TOML 'yes'
      # history_length = 20;
      # dmenu = "/usr/bin/dmenu -p dunst:";
      # browser = "/usr/bin/xdg-open";
      # always_run_script = true;
      # title = "Dunst";
      # class = "Dunst";
      # corner_radius = 0;
      # corners = "all";
      # ignore_dbusclose = false;
      # force_xwayland = false;
      # force_xinerama = false;
      # mouse_left_click = "close_current";
      # mouse_middle_click = "do_action, close_current";
      # mouse_right_click = "close_all";
      # };

      # From [experimental]
      # experimental = {
      #   per_monitor_dpi = false;
      # };

      # From [urgency_low]
      urgency_low = {
        background = "#1d2021";
        foreground = "#d4be98";
        frame_color = "#7daea3";
        timeout = 10;
        default_icon = "dialog-information";
      };

      # From [urgency_normal]
      urgency_normal = {
        background = "#1d2021";
        foreground = "#d4be98";
        frame_color = "#a9b665";
        timeout = 10;
        override_pause_level = 30;
        default_icon = "dialog-information";
      };

      # From [urgency_critical]
      urgency_critical = {
        background = "#3c1f1e";
        foreground = "#ddc7a1";
        frame_color = "#ea6962";
        timeout = 0;
        override_pause_level = 60;
        default_icon = "dialog-warning";
      };
    };
  };
}
