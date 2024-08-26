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
    gruvbox-dark = {
      theme = {
        name = "Gruvbox-Dark";
        package = pkgs.gruvbox-gtk-theme;
      };
      iconTheme = {
        name = "oomox-Gruvbox-Dark";
        package = pkgs.gruvbox-gtk-theme;
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
    inherit (themes.gruvbox-dark) iconTheme theme;

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
  };
}
