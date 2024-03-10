{lib, ...}: {
  environment.variables = "xterm";
  networking.useHostResolvConf = lib.mkForce false;

  # Use systemd-resolved inside the container
  # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
  services.resolved.enable = true;
}
