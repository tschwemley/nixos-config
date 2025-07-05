{pkgs, ...}: {
  home.packages = let
    brave = pkgs.brave.override {
      commandLineArgs = [
        "--enable-features=TouchpadOverscrollHistoryNavigation"
      ];
    };
    vivaldi = pkgs.vivaldi.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    };
  in
    with pkgs; [
      brave
      lynx
      mullvad-browser
      tor-browser
      ungoogled-chromium
      vivaldi
      zen-browser
    ];
}
