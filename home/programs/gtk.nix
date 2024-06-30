{pkgs, ...}: let
  themes = {
    everforest = {
      iconTheme = {
        name = "Everforest-Dark";
        package = pkgs.everforest-gtk-theme;
      };
      theme = {
        name = "Everforest-Dark-BL";
        package = pkgs.everforest-gtk-theme;
      };
    };
  };
in {
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    inherit (themes.everforest) iconTheme theme;

    enable = true;

    # font = {
    #   name = config.fontProfiles.regular.family;
    #   size = 12;
    # };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    # possible themes:
    # everforest-gtk-theme
    # gruvbox-dark-gtk
    # gruvbox-gtk-theme
    # https://github.com/matthewmx86/Redmond97

    # theme = {
    #   name = "Everforest-Dark-BL";
    #   package = pkgs.everforest-gtk-theme;
    #   # name = "adw-gtk3-dark";
    #   # package = pkgs.adw-gtk3;
    # };
    # iconTheme = {
    #   name = "Papirus";
    #   package = pkgs.papirus-icon-theme;
    # };
  };

  # services.xsettingsd = {
  #   enable = true;
  #   settings = {
  #     "Net/ThemeName" = "${gtk.theme.name}";
  #     "Net/IconThemeName" = "${gtk.iconTheme.name}";
  #   };
  # };
}
