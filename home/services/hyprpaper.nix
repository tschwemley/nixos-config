{inputs', ...}: {
  services.hyprpaper = {
    enable = true;
    package = inputs'.hyprpaper.packages.default;
    settings = {
      preload = ["/home/schwem/Pictures/wallpaper/2011-07-28_19-36-35_649.jpg"];
      wallpaper = [", /home/schwem/Pictures/wallpaper/2011-07-28_19-36-35_649.jpg"];
    };
  };
}
