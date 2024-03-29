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
    ../programs/bambu-studio.nix
    ../programs/brave.nix
    ../programs/cad.nix
    ../programs/cura.nix
    ../programs/firefox.nix
    ../programs/glow.nix
    ../programs/godot.nix
    ../programs/ollama.nix
    ../programs/slack.nix
    ../programs/spotify.nix
    # TODO: wait for upstream fix or write overlay
    ../programs/sonic-pi.nix
    ../programs/taskwarrior.nix
    ../programs/vlc.nix
    ../programs/wayland
    ../programs/wcalc.nix
    ../programs/wiki-tui.nix
    ../programs/turbovnc.nix
    ../programs/zoom.nix
    ../services/kdeconnect.nix
    # ../services/spotifyd.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };
}
