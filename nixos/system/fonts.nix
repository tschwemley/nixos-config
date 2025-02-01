{pkgs, ...}: let
  nerdfonts = with pkgs.nerd-fonts; [
    _0xproto
    fira-code
    hasklug
    iosevka
    symbols-only
  ];
in {
  environment.systemPackages = with pkgs; [
    fontconfig
  ];

  fonts = {
    fontconfig.enable = true;
    fontDir.enable = true;

    packages = with pkgs;
      [
        hasklig
        inter # used for reaper theme(s)
        noto-fonts-emoji
      ]
      ++ nerdfonts;
  };
}
