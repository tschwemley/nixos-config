{
  lib,
  pkgs,
  ...
}: {
  documentation = {
    enable = true;

    man = {
      enable = true;
      # NOTE: originally flipped
      man-db.enable = true;
      mandoc.enable = false;

      # generateCaches = true;
      generateCaches = lib.mkForce false;
    };
  };

  environment.systemPackages = with pkgs; [
    linux-manual
    man-pages
    man-pages-posix
  ];
}
