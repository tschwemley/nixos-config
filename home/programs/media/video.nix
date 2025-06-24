{ pkgs, ... }:
{
  home.packages = with pkgs; [
    celluloid
    ffmpeg
    vlc
    webcamoid
  ];
}
