{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ podman-compose ];
  programs = {
    bash.shellAliases.docker-compose = "podman-compose";
    zsh.shellAliases.docker-compose = "podman-compose";
  };

  # Enable container name DNS for all Podman networks.
  networking.firewall.interfaces =
    let
      matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
    in
    {
      "${matchAll}".allowedUDPPorts = [ 53 ];
    };

  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      autoPrune.enable = true;
      dockerCompat = true;

      # Required for container networking to be able to use names
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "podman";
  };
}
