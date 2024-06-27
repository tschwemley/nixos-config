{pkgs, ...}: {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    # font = {
    #   name = config.fontProfiles.regular.family;
    #   size = 12;
    # };
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };

  # services.xsettingsd = {
  #   enable = true;
  #   settings = {
  #     "Net/ThemeName" = "${gtk.theme.name}";
  #     "Net/IconThemeName" = "${gtk.iconTheme.name}";
  #   };
  # };
}
