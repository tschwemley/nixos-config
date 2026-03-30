{ pkgs, ... }:
{
  imports = [
    ./zen
  ];

  home = {
    packages =
      let
        brave = pkgs.brave.override {
          commandLineArgs = [
            "--enable-features=TouchpadOverscrollHistoryNavigation"
          ];
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

    sessionVariables.MOZ_ENABLE_WAYLAND = 1;
  };
}
