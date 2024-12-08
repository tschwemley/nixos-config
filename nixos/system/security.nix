{
  security = {
    pam = {
      services.hyprlock = {};
    };
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
}
