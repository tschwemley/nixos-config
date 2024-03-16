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
