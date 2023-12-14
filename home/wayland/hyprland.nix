{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs.split-monitor-workspaces.packages.${pkgs.system}) split-monitor-workspaces;
in {
  imports = [
    ../programs/eww
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    clipman
    # grim # grab images
    # grimblast # grab images
    hyprpaper # wallpaper
    hyprpicker #color picker
    hyprshot #screenshot
    # slurp # select a region (used in conjunction w/ grim)
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    GDK_SCALE = 1.25;
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    XCURSOR_SIZE = 32;
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      general {
        layout = master
      }

      master {
        new_is_master = false
        orientation = right
      }

      # plugin {
      #   split-monitor-workspaces {
      #       count = 5
      #   }
      # }

      # unscale XWayland
      xwayland {
        force_zero_scaling = true
      }
    '';

    plugins = [
      split-monitor-workspaces
    ];

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
        "$mod, p, exec, ${pkgs.rofi}/bin/rofi -show drun"

        "alt, tab, layoutmsg, cyclenext"
        "alt shift, tab, layoutmsg, cycleprev"
        "$mod, l, layoutmsg, swapnext"
        "$mod, h, layoutmsg, swapprev"
        "$mod shift, h, movewindow, mon:1"
        "$mod shift, l, movewindow, mon:0"
        "$mod, w, killactive"

        # "$mod, 1, split-workspace, 1"
        # "$mod, 2, split-workspace, 2"
        # "$mod, 3, split-workspace, 3"
        # "$mod, 4, split-workspace, 4"
        # "$mod, 5, split-workspace, 5"
      ];

      exec-once = [
        # "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "hyprpaper"
        "xrandr --output DP-2 --auto"
        "xrandr --output HDMI-A-2 --auto"
        "xrandr --output HDMI-A-2 --primary"
      ];

      monitor = [
        "HDMI-A-2,3840x2160@120,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      # workspace = [
      #   "HDMI-A-2,1"
      #   "DP-2,2"
      #   "HDMI-A-2,3"
      #   "DP-2,4"
      #   "HDMI-A-2,5"
      #   "DP-2,6"
      # ];
    };

    systemd.enable = true;
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
  '';
}
