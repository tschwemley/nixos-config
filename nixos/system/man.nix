{ pkgs, ... }:
{
  documentation = {
    dev.enable = true;

    man = {
      enable = true;
      cache.enable = true;
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
