{pkgs, ...}: {
  home.packages = with pkgs; [
    celluloid
    ffmpeg
    mpv
    vlc
    webcamoid
  ];
}
