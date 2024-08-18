{config, ...}: {
  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;

    cursor = {
      inactive_timeout = 4;
      no_break_fs_vrr = true;
      no_hardware_cursors = true;
    };

    exec-once = [
      "ags -c ~/nixos-config/home/programs/ags/config/config.js"
    ];

    general = {
      gaps_out = 10;
      # layout = "dwindle";
      layout = "master";
      # layout = "scroller";
    };

    master = {
      # for all options see: https://wiki.hyprland.org/Configuring/Master-Layout/
      always_center_master = true;
      orientation = "center";
    };

    misc = {
      #TODO: validate I want to keep these settings... they're copy/pasted
      # disable auto polling for config file changes
      # disable_autoreload = true;

      # disable the stupid default anime background
      disable_hyprland_logo = true;
      force_default_wallpaper = 0;

      # disable dragging animation
      # animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 2;
    };

    monitor = config.hyprland.monitors;

    render = {
      direct_scanout = true;
    };

    plugin = {
      # easymotion = {
      #   textsize = 20;
      #   textcolor = "rgba(43ff64d9)";
      #   textfont = "Hasklig";
      # };
    };

    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
    ];
  };
}
