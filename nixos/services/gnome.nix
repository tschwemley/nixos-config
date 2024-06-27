{pkgs, ...}: {
  services = {
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome.gnome-settings-daemon
    ];

    gnome.glib-networking.enable = true;

    gvfs.enable = true;
  };
}
