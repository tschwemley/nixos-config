{ pkgs, ... }:
{
  documentation = {
    dev.enable = true;

    man = {
      enable = true;
      generateCaches = true;
    };
  };

  environment = {
    sessionVariables.MANPAGER = "nvim +Man!";

    systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];
  };
}
