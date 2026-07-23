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
    friture
    (streamlink.overrideAttrs (prev: {
      disabledTests = prev.disabledTests ++ [ "test_read_timeout" ];
    }))
  ];
}
