{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # handbrake
    ffmpeg-full
    mpv
    vlc
    webcamoid
  ];
}
