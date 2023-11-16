{...}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    git
    ./.
    ../programs/brave.nix
    ../programs/discord.nix
    ../programs/firefox.nix
    ../programs/flameshot.nix
    ../programs/github.nix
    ../programs/glow.nix
    ../programs/godot.nix
    ../programs/reaper.nix
    ../programs/rbw.nix
    ../programs/rofi.nix
    ../programs/rustdesk.nix
    ../programs/slack.nix
    ../programs/strawberry.nix
    ../programs/sonic-pi.nix
    ../programs/spotify.nix
    ../programs/tigervnc.nix
    ../programs/visidata.nix
    ../programs/vlc.nix
    ../programs/wezterm
    ../programs/wiki-tui.nix
    ../programs/zk
    ../programs/zoom.nix
    ../wayland/hyprland.nix
  ];

  home.username = "schwem";
  home.homeDirectory = "/home/schwem";

  # TODO: move this to system level or someplace more appropriate at a later date
  xdg.configFile = {
    "awesome/rc.lua".source = ../xdg-config/awesome/rc.lua;
  };
}
