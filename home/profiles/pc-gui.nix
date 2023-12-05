{...}: {
  imports = [
    ./pc.nix
    ../programs/bambu-studio.nix
    ../programs/brave.nix
    ../programs/discord.nix
    ../programs/firefox.nix
    ../programs/flameshot.nix
    ../programs/godot.nix
    ../programs/hypnotix.nix
    ../programs/musikcube.nix
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

  # sops = {
  #   # age.keyFile = "/home/schwem/.config/sops/age/keys.txt"; # must have no password!
  #   defaultSopsFile = ./secrets.yaml;
  #   secrets.spotifyd = {
  #     # %r gets replaced with a runtime directory, use %% to specify a '%'
  #     # sign. Runtime dir is $XDG_RUNTIME_DIR on linux and $(getconf
  #     # DARWIN_USER_TEMP_DIR) on darwin.
  #     path = "/home/schwem/.config/spotifyd/spotifyd.conf";
  #   };
  # };

  # TODO: move this to system level or someplace more appropriate at a later date
  xdg.configFile = {
    "awesome/rc.lua".source = ../xdg-config/awesome/rc.lua;
  };
}
