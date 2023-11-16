{...}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    ./pc.nix
    ../programs/brave.nix
    ../programs/discord.nix
    ../programs/firefox.nix
    ../programs/flameshot.nix
    ../programs/godot.nix
    ../programs/reaper.nix
    ../programs/rbw.nix
    ../programs/rofi.nix
    ../programs/rustdesk.nix
    ../programs/nzbget.nix
    ../programs/slack.nix
    ../programs/sonic-pi.nix
    ../programs/spotify.nix
    ../programs/tigervnc.nix
    ../programs/unity.nix
    ../programs/vlc.nix
    ../programs/zoom.nix
    ../wayland/hyprland.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };

  # TODO: move this to system level or someplace more appropriate at a later date
  xdg.configFile = {
    "awesome/rc.lua".source = ../xdg-config/awesome/rc.lua;
  };
}
