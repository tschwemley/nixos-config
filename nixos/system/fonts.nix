{
  lib,
  pkgs,
  ...
}: let
  nerdfonts = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  # nerdfonts = with pkgs.nerd-fonts; [
  #   _0xproto
  #   agave
  #   fira-code
  #   hasklug
  #   iosevka
  #   iosevka-term
  #   jetbrains-mono
  #   lilex
  #   symbols-only
  # ];
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
