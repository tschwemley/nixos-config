{pkgs, ...}: {
  documentation = {
    dev.enable = true;
    man.generateCaches = true;
  };

  environment.systemPackages = with pkgs; [man-pages man-pages-posix];
}
