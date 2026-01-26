{ pkgs, ... }:
let
  themes = import ./themes.nix pkgs;
in
{
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    # inherit (themes.gruvbox-dark) iconTheme theme;
    inherit (themes.gruvbox-material-dark) iconTheme theme;

    enable = true;

    font = {
      name = "Ioveska";
      # size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
