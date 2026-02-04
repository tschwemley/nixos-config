{ pkgs, ... }:
{
  imports = [
    # ./books.nix
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
