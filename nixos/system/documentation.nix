{
  lib,
  pkgs,
  ...
}:
{
  documentation = {
    enable = true;

    man = {
      enable = true;
      cache.enable = lib.mkForce false;
      man-db.enable = true;
      mandoc.enable = false;
    };
  };

  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
}
