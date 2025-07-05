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
    fontconfig = {
      enable = true;

      defaultFonts = {
        # emoji = ["OpenMoji Color"];
        emoji = ["Twitter Color Emoji"];
        serif = ["DaddyTimeMono Nerd Font"];
        monospace = ["CaskaydiaCove Nerd Font"];
        sansSerif = ["CaskaydiaCove Nerd Font"];
      };

      hinting = {
        enable = true;
        # TODO: switch back to slight if full/medium make font lose shape
        # style = "full"; # default is slight. other option is medium
      };
    };

    # fontDir.enable = true; TODO: reenable if comapatbility issues. Otherwise delete

    packages = with pkgs;
      [
        hasklig
        inter # used for reaper theme(s)

        # TODO: only keep the ones I give a fuck about
        openmoji-black
        openmoji-color
        noto-fonts-color-emoji
        twemoji-color-font
      ]
      ++ nerdfonts;
  };
}
