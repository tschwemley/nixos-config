{
  boot.loader.systemd-boot = {
    enable = true;
    editor = false; # leaving true allows for root access to be gained via passing kernel param
  };
}
