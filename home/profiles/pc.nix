{...}: let
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
    ../programs/ai
    ../programs/audio
    ../programs/bambu-studio.nix
    ../programs/browsers
    ../programs/cad.nix
    ../programs/glow.nix
    ../programs/rofi.nix
    ../programs/slack.nix
    ../programs/spotify.nix
    # TODO: wait for upstream fix or write overlay
    ../programs/taskwarrior.nix
    ../programs/vlc.nix
    ../programs/wayland
    ../programs/wcalc.nix
    ../programs/tigervnc.nix
    ../programs/zoom.nix
    ../services/kdeconnect.nix
    # ../services/spotifyd.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };
}
