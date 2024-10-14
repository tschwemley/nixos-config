{ pkgs, ... }:
{
  home.packages = [
    (pkgs.brave.override {
      commandLineArgs = [
        "--enable-features=TouchpadOverscrollHistoryNavigation"
      ];
    })
  ];
}
