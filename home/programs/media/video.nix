{ pkgs, ... }:
{
  home.packages = with pkgs; [
    celluloid
    handbrake
    ffmpeg-full
    mpv
    vlc
    webcamoid
  ];
}
