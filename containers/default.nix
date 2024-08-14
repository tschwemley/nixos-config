{lib, ...}: {
  environment.variables = {
    TERM = "xterm";
  };

  networking = {
    firewall.enable = true;
    # nftables.enable = true;
    useHostResolvConf = lib.mkForce false;
  };

  # Use systemd-resolved inside the container
  # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    domains = ["~."];
    fallbackDns = ["194.242.2.2" "2a07:e340::2"];
    # fallbackDns = ["1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001"];
    # dnsovertls = "true";
  };

  system.stateVersion = "24.05";
}


/*
{lib, ...}: {
  environment.variables = {
    TERM = "xterm";
  };

  networking = {
    firewall.enable = true;
    useHostResolvConf = lib.mkForce false;
  };

  # Use systemd-resolved inside the container
  # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
  services.resolved.enable = true;

  system.stateVersion = "24.05";
}
*/
