{
  wayland.windowManager.hyprland.settings = {
    env = ["QT_WAYLAND_DISABLE_WINDOWDECORATION,1"];

    exec-once = [
      "hyprpaper"
      "xrandr --output DP-1 --auto --primary"
      # "xrandr --output DP-2 --auto"
      # "xrandr --output HDMI-A-2 --auto"
      # "xrandr --output HDMI-A-2 --primary"
    ];

    general = {
      # layout = "scroller";
      # layout = "master";
      layout = "dwindle";
    };

    master = {
      new_is_master = false;
      orientation = "center";
    };

    monitor = [
      # "HDMI-A-2,3840x2160@120,0x0,1" # LG C2
      # "DP-2,2560x2880@60,3840x0,1" # LG Dual Up
      "DP-1,5120x3440@240,0x0,1" # Odyssey g9
    ];

    plugin = {
      easymotion = {
        textsize = 20;
        textcolor = "rgba(43ff64d9)";
        textfont = "Hasklig";
      };
    };

    xwayland = {
      force_zero_scaling = true;
    };

    workspace = [
      "1, monitor:DP-1"
      "2, monitor:DP-1"
      "3, monitor:DP-1"
      "4, monitor:DP-1"
      # "1, monitor:HDMI-A-2"
      # "2, monitor:DP-2"
      # "3, monitor:HDMI-A-2"
      # "4, monitor:DP-2"
    ];
  };
}
