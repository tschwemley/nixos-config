{pkgs, ...}: {
  imports = [
    ./jellyfin.nix
    ./spotify.nix
    ./vlc.nix
  ];

  home.packages = with pkgs; [
    audacity
    ffmpeg
    mediainfo
  ];
}
