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
    ../programs/firefox.nix
    ../programs/glow.nix
    ../programs/godot.nix
    # TODO: fix ollama on 24.05
    # ../programs/ollama.nix
    ../programs/rofi.nix
    ../programs/slack.nix
    # TODO: wait for upstream fix or write overlay
    # ../programs/sonic-pi.nix
    ../programs/taskwarrior.nix
    ../programs/vlc.nix
    ../programs/wayland
    ../programs/wiki-tui.nix
    ../programs/tigervnc.nix
    ../programs/zoom.nix
    ../services/spotifyd.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };
}
