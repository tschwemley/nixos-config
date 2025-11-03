{
  imports = [
    # ./onlykey.nix
    ./yubikey.nix
  ];

  security = {
    pam = {
      services.hyprlock = { };
    };
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
}
