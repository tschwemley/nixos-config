{ lib, pkgs, ... }: {
  home.packages = [ pkgs.videoduplicatefinder ];

  xdg.desktopEntries.videoduplicatefinder = {
    name = "Video Duplicate Finder";

    comment = "Find duplicate video and image files based on visual similarity";
    exec = lib.getExe pkgs.videoduplicatefinder;
    genericName = "Duplicate File Finder";
    icon = "${pkgs.videoduplicatefinder}/share/videoduplicatefinder/icon.png";
    startupNotify = true;
    type = "Application";

    categories = [ "Utility" ];
  };
}
