{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    age-plugin-yubikey
    yubikey-agent
    yubikey-manager
    yubikey-personalization
  ];

  services = {
    pcscd.enable = true;
    udev.packages = with pkgs; [yubikey-personalization];
  };
}
