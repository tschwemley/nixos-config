{
  services.displayManager = {
    # autoLogin = {
    #   enable = true;
    #   user = "schwem";
    # };

    dux-greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/schwem";
    };
  };

  # qt.enable = true;

  # systemd.user.services.niri-flake-polkit.enable = false;
}
