{lib, ...}: {
  environment.variables = {
    TERM = "xterm";
  };

  networking = {
    firewall.enable = true;
    nftables.enable = true;
    useHostResolvConf = lib.mkForce false;
  };

  # Use systemd-resolved inside the container
  # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
    domains = ["~."];
    fallbackDns = [
      "194.242.2.2"
      "2a07:e340::2"
    ];
  };

  system.stateVersion = "24.05";
}
