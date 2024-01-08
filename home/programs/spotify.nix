{pkgs, ...}: {
  home.packages = with pkgs; [
    # spotify
    spotifyd
    spotify-tui
  ];
}
