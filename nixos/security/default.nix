{ pkgs, ... }: {
  imports = [
    ./yubikey.nix
  ];

  environment.systemPackages = with pkgs; [
    hashcat
    john
  ];

  security = {
    pam = {
      services.hyprlock = { };
    };
    polkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };
}
