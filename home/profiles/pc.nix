{...}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    git
    ./.
    ../programs/aseprite.nix
    ../programs/bambu-studio.nix
    ../programs/brave.nix
    ../programs/firefox.nix
    ../programs/glow.nix
    ../programs/godot.nix
    ../programs/ollama.nix
    ../programs/rofi.nix
    ../programs/slack.nix
    ../programs/sonic-pi.nix
    ../programs/taskwarrior.nix
    ../programs/vlc.nix
    ../programs/wayland/hyprland
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
