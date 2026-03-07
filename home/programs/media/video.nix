{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # handbrake
    # ffmpeg-full
    ffmpeg-headless
    mpv
    vlc
    webcamoid
  ];
}
