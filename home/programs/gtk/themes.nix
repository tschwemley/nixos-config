pkgs: {
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
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
}
