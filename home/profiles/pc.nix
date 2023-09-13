{...}: {
  imports = [
    ./.
    ../programs/brave.nix
    ../programs/discord.nix
    ../programs/firefox.nix
    ../programs/flameshot.nix
    ../programs/reaper.nix
    ../programs/rbw.nix
    ../programs/rofi.nix
    ../programs/rustdesk.nix
    ../programs/slack.nix
    ../programs/sonic-pi.nix
    ../programs/spotify.nix
    ../programs/tigervnc.nix
    ../programs/visidata.nix
    ../programs/vlc.nix
    ../programs/wezterm
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
