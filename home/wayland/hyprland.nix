{
  pkgs,
  system,
  ...
}: {
  imports = [
    ../programs/eww
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    clipman
    grim # grab images
    hyprpaper # wallpaper
    hyprpicker #color picker
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
    slurp # select a region (used in conjunction w/ grim)
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      "/nix/store/yhwdlzii9a29r92a6az579gx1mwa838k-hyprbars-0.1/lib/libhyprbars.so"
    ];

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
        "$mod, p, exec, ${pkgs.rofi}/bin/rofi -show drun"
      ];

      env = [
        # toolkit-specific scale
        "GDK_SCALE,2"
        "XCURSOR_SIZE,32"
      ];

      exec-once = [
        "hyprpaper"
      ];

      monitor = [
        "HDMI-A-2,3840x2160,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      workspace = [
        # "name:start, monitor:HDMI-A-2, default: true"
      ];
    };

    extraConfig = ''
      # unscale XWayland
      xwayland {
        force_zero_scaling = true
      }
    '';
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
  '';
}
