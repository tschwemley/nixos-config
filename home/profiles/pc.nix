{pkgs, ...}: let
  git = import ../programs/git.nix {
    inherit pkgs;
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    git
    ./.
    ../programs/ags
    ../programs/ai
    ../programs/bambu-studio.nix
    ../programs/bitwarden.nix
    ../programs/browsers
    ../programs/discord.nix
    ../programs/glow.nix
    ../programs/gtk.nix
    ../programs/khal.nix
    ../programs/libreoffice.nix
    ../programs/music
    ../programs/qt.nix
    ../programs/slack.nix
    ../programs/vlc.nix
    ../programs/wayland
    ../programs/wcalc.nix
    ../programs/tigervnc.nix
    ../programs/vial.nix
    ../programs/wofi.nix
    ../programs/zoom.nix
    ../terminal/xdg.nix
    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix

    # ../programs/aseprite.nix
    # ../programs/cad.nix
    # ../programs/rustdesk.nix
    # ../programs/taskwarrior.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };

  # TODO: move all of the below out if keeping
  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # TODO: move out from this file
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
