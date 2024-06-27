{
  # inputs, TODO: remove if not using flatpak
  pkgs,
  ...
}: let
  git = import ../programs/git.nix {
    name = "Tyler Schwemley";
    email = "tjschwem@gmail.com";
  };
in {
  imports = [
    # inputs.nix-flatpak.homeManagerModules.nix-flatpak
    git
    ./.
    # ../programs/aseprite.nix
    # ../programs/ai
    ../programs/bambu-studio.nix
    ../programs/bitwarden.nix
    ../programs/browsers
    ../programs/cad.nix
    ../programs/glow.nix
    ../programs/gtk.nix
    ../programs/music
    ../programs/rustdesk.nix
    ../programs/slack.nix
    ../programs/taskwarrior.nix
    ../programs/vlc.nix
    ../programs/wayland
    ../programs/wcalc.nix
    ../programs/tigervnc.nix
    ../programs/vial.nix
    ../programs/wofi.nix
    ../programs/zoom.nix
    ../services/kdeconnect.nix
    ../services/mpris-proxy.nix
  ];

  home = {
    username = "schwem";
    homeDirectory = "/home/schwem";
  };

  # qt = {
  #   enable = true;
  #   platformTheme.name = "gtk3";
  #   #style = "gtk2";
  # };

  # TODO: move all of the below out if keeping
  # Also sets org.freedesktop.appearance color-scheme
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  # TODO: uncomment and move out if continuing to use flatpak
  # services.flatpak.packages = [
  #   {
  #     appId = "com.brave.Browser";
  #     origin = "flathub";
  #   }
  # ];

  # TODO: move out from this file
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
