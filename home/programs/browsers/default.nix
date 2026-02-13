{ pkgs, ... }:
{
  imports = [
    ./zen.nix
  ];

  home.packages =
    let
      brave = pkgs.brave.override {
        commandLineArgs = [
          "--enable-features=TouchpadOverscrollHistoryNavigation"
        ];
      };
      vivaldi = pkgs.vivaldi.override {
        commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
      };
    in
    with pkgs;
    [
      brave
      ladybird
      lynx
      mullvad-browser
      tor-browser
      vivaldi
    ];
}
