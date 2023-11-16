{pkgs, ...}: {
  imports = [
    ../programs/eww
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    clipman
    grim # grab images
    hyprpaper # wallpaper
    hyprpicker #color picker
    slurp # select a region (used in conjunction w/ grim)
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11";
    GDK_SCALE = 1.25;
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    XCURSOR_SIZE = 32;
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

      # unscale XWayland
      xwayland {
        force_zero_scaling = true
      }
    '';

    plugins = [
      # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      # hyprbars
    ];

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
        "$mod, p, exec, ${pkgs.rofi}/bin/rofi -show drun"

        "alt, tab, layoutmsg, cyclenext"
        "alt shift, tab, layoutmsg, cycleprev"
        "$mod, h, layoutmsg, swapnext"
        "$mod, l, layoutmsg, swapprev"
        "$mod, w, killactive"
      ];

      exec-once = [
        "hyprpaper"
      ];

      monitor = [
        "HDMI-A-2,3840x2160,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      workspace = [
        "HDMI-A-2,1"
        "HDMI-A-2,3"
        "HDMI-A-2,5"
        "HDMI-A-2,7"
        "HDMI-A-2,9"
        "DP-2,2"
        "DP-2,4"
        "DP-2,6"
        "DP-2,8"
        "DP-2,10"
      ];
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
