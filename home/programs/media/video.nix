{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    ffmpeg
    handbrake
    mediainfo
    shotcut
    vlc
  ];
}
