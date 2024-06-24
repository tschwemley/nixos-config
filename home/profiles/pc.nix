{pkgs, ...}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    git
    ./.
    # ../programs/aseprite.nix
    ../programs/ags
    # ../programs/ai
    ../programs/bambu-studio.nix
    ../programs/browsers
    ../programs/cad.nix
    ../programs/glow.nix
    ../programs/music
    ../programs/rofi.nix
    ../programs/rustdesk.nix
    ../programs/slack.nix
    ../programs/taskwarrior.nix
    ../programs/vlc.nix
    ../programs/wayland
    ../programs/wcalc.nix
    ../programs/tigervnc.nix
    ../programs/vial.nix
    ../programs/zoom.nix
    ../services/kdeconnect.nix
    # ../services/spotifyd.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };
}
