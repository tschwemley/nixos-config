{pkgs, ...}: {
  home.packages = let
    brave = pkgs.brave.override {
      commandLineArgs = [
        "--enable-features=TouchpadOverscrollHistoryNavigation"
      ];
    };
  in
    with pkgs; [
      brave
      lynx
      mullvad-browser
      tor-browser
      ungoogled-chromium
      zen-browser
    ];
}
