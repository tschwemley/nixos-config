{
  imports = [ ./. ];

  boot = {
    initrd = {
      systemd.enable = true;
    };

    loader.systemd-boot = {
      enable = true;

      configurationLimit = 10;
      editor = false; # leaving true allows for root access to be gained via passing kernel param
    };
  };
}
