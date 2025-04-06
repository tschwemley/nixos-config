{pkgs, ...}: {
  environment.systemPackages = with pkgs; [podman-compose];

  # Enable container name DNS for non-default Podman networks.
  # https://github.com/NixOS/nixpkgs/issues/226365
  networking.firewall.interfaces."podman*".allowedUDPPorts = [
    53
    5353
  ];

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      autoPrune.enable = true;
      dockerCompat = true;

      # Required for container networking to be able to use names
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
