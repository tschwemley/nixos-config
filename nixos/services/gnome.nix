{pkgs, ...}: {
  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome-settings-daemon
    ];

    # minimally necessary for bambu-studio
    gnome.glib-networking.enable = true;

    gvfs.enable = true;
  };
}
