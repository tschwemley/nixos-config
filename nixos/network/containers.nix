{config, ...}: {
  networking.nat = {
    enable = true;
    # internalInterfaces = ["ve-+" "veth0" "podman0"];
    internalInterfaces = ["ve-+"];
    externalInterface =
      if (config ? ethDev)
      then config.ethDev
      else "ens3";
    # Lazy IPv6 connectivity for the container
    enableIPv6 = true;
  };
}
