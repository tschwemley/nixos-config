{pkgs, ...}: {
  imports = [
    ../programs/eww
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    hyprpaper
    hyprpicker
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    # extraConfig = ''
    #   exec-once=hyprpaper
    # '';

    plugins = [
      "/nix/store/yhwdlzii9a29r92a6az579gx1mwa838k-hyprbars-0.1/lib/libhyprbars.so"
    ];

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, Return, exec, ${pkgs.wezterm}/bin/wezterm"
        "$mod, p, exec, ${pkgs.rofi}/bin/rofi -show drun"
      ];

      exec-once = [
        "hyprpaper"
      ];

      monitor = [
        "HDMI-A-2,3840x2160,0x0,1"
        "DP-2,2560x2880@60,3840x0,1"
      ];

      workspace = [
        # "name:start, monitor:DP-2, default: true"
        # "name:code, monitor:DP-2"
        # "name:start, monitor:HDMI-1, default: true"
        # "name:code, monitor:HDMI-1"
      ];
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
  '';
}
