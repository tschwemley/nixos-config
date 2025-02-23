{pkgs, ...}: {
  imports = [
    ./jellyfin.nix
    ./spotify.nix
    ./loupe.nix
    ./video.nix
  ];

  home.packages = with pkgs; [
    audacity
    streamlink
  ];
}
