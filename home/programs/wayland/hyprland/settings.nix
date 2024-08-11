{
  wayland.windowManager.hyprland.settings = {
    debug.disable_logs = false;

    cursor = {
      inactive_timeout = 4;
      #min_refresh_rate = 120;
      no_break_fs_vrr = true;
      no_hardware_cursors = true;
    };

    exec-once = [
      "hyprpaper"
      "ags -c ~/nixos-config/home/programs/ags/config/config.js"
      # "waybar"
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

    monitor = [
      # "HDMI-A-2,3840x2160@120,0x0,1" # LG C2
      # "DP-2,2560x2880@60,3840x0,1" # LG Dual Up
      "DP-1,5120x3440@240,0x0,1" # Odyssey g9
    ];

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

    # xwayland.force_zero_scaling = true;

    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
    ];
  };
}
