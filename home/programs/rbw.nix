{config, pkgs, ...}: {
  # home-manager also wraps this in 'programs' but I don't see need since I don't want hm to manage
  # my config file
  home.packages = with pkgs; [
    rbw
    pinentry
  ];

}
