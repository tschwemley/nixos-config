{
  # TODO: uncomment below after unfucking my shit up for the asdfa321349873210348723 time
  imports = [
    ./.
    ../programs/ai
    ../programs/browsers
    ../programs/communication
    ../programs/creative
    ../programs/development/dbgate.nix
    ../programs/gtk
    ../programs/media
    ../programs/music

    # ../programs/aseprite.nix
    ../programs/bambu-studio.nix
    ../programs/bitwarden.nix
    ../programs/glow.nix
    ../programs/khal.nix
    ../programs/lan-mouse.nix
    ../programs/libreoffice.nix
    ../programs/qt.nix
    ../programs/rustdesk.nix
    # ../programs/tailscale-systray.nix
    # ../programs/tigervnc.nix
    ../programs/wayland/hyprland.nix
    ../programs/wcalc.nix
    ../programs/wofi.nix

    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix
    ../services/status-notifier-watcher.nix

    ../theme

    ../terminal/kitty

    ../xdg
    ../xdg/netrc.nix
    ../xdg/ssh/personal.nix

    # TODO: go through and decide which to keep and which to remove
    # ../programs/cad.nix
    # ../programs/taskwarrior.nix
  ];

  home = {
    homeDirectory = "/home/schwem";
    username = "schwem";

    sessionVariables = {
      VISUAL = "nvim";
    };
  };

  # pc specific program config
  programs = {
    git.extraConfig.url = {
      "ssh://gh" = {
        insteadOf = "https://github.com";
      };
    };

    # TODO: remove this or move out
    neovide = {
      enable = true;
      settings = {};
    };
  };
}
