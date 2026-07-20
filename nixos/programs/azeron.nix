{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.azeron-software ];

  services.udev.packages = [
    pkgs.azeron-software
  ];
}
