{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    # ./books.nix
    ./jellyfin.nix
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
