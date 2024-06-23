{pkgs, ...}: {
  home.packages = [pkgs.hyprpaper];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload=/home/schwem/.config/hypr/dual-bg.jpg
    preload=/home/schwem/.config/hypr/lg-bg.jpg
    # preload=/home/schwem/.config/hypr/wallhaven-l8jp7y.png
    preload=/home/schwem/.config/hypr/wallhaven-weverr.jpg
    preload=/home/schwem/.config/hypr/wallhaven-1kpjv1.png
    wallpaper=DP-2,/home/schwem/.config/hypr/dual-bg.jpg
    wallpaper=HDMI-A-2,/home/schwem/.config/hypr/lg-bg.jpg
    wallpaper=DP-1,/home/schwem/.config/hypr/wallhaven-1kpjv1.png
  '';
}
