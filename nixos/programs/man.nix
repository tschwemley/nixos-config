{pkgs, ...}: {
  documentation = {
    dev.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
  };

  environment.systemPackages = with pkgs; [man-pages man-pages-posix];
}
