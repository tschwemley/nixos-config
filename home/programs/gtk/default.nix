{pkgs, ...}: let
  themes = import ./themes.nix pkgs;
in {
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";

  gtk = {
    inherit (themes.gruvbox-dark) iconTheme theme;

    enable = true;

    font = {
      # name = "0xProtoNerdFontPropo-Regular";
      # name = "Hasklug Nerd Font Mono";
      # name = "Fira Code";
      name = "Ioveska";
      # size = 12;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # nemo = gui file explorer
  home.packages = [pkgs.nemo];
}
