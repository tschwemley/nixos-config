{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mosquitto
    netclient
    netmaker
  ];

  # services.mosquitto.enable = true;
}
