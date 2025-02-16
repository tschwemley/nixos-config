{pkgs, ...}: {
  imports = [
    ./jellyfin.nix
    ./spotify.nix
    ./loupe.nix
    ./vlc.nix
  ];

  home.packages = with pkgs; [
    audacity
    handbrake
    ffmpeg
    mediainfo
    shotcut
    streamlink
  ];
}
