{
  imports = [
    ./.
    ../programs/ags
    ../programs/ai
    ../programs/browsers
    ../programs/communication
    ../programs/gnome

    ../programs/aseprite.nix
    ../programs/bambu-studio.nix
    ../programs/bitwarden.nix
    ../programs/glow.nix
    ../programs/jellyfin.nix
    ../programs/jira-cli.nix
    ../programs/khal.nix
    ../programs/libreoffice.nix
    ../programs/music
    ../programs/qt.nix
    ../programs/tailscale-systray.nix
    ../programs/tigervnc.nix
    ../programs/vial.nix
    ../programs/vlc.nix
    ../programs/wayland/hyprland.nix
    ../programs/wcalc.nix
    ../programs/wofi.nix
    ../terminal/kitty
    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix
    ../xdg
    ../xdg/ssh/servers.nix
    ../xdg/ssh/personal.nix
    ../xdg/ssh/work.nix

    # TODO: go through and decide which to keep and which to remove
    # ../programs/cad.nix
    # ../programs/dbgate.nix
    # ../programs/rustdesk.nix
    # ../programs/taskwarrior.nix
  ];

  home = {
    homeDirectory = "/home/schwem";
    username = "schwem";

    sessionVariables = {
      VISUAL = "nvim";
    };
  };
}
