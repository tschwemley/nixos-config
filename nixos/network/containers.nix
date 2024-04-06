{config, ...}: {
  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["ve-*"];
      externalInterface =
        if (config ? ethDev)
        then config.ethDev
        else "ens3";
      # Lazy IPv6 connectivity for the container
      enableIPv6 = true;
    };

    networkmanager.unmanaged = ["interface-name:ve-*"];
  };
}
