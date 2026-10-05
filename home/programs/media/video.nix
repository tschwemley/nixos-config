{ pkgs, ... }:
{
  imports = [ ./videoduplicatefinder.nix ];

  home.packages = with pkgs; [
    # handbrake
    ffmpeg
    mediainfo
    mpv
    vlc
    webcamoid
  ];
}
