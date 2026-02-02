# { inputs, ... }:
{
  imports = [
    # inputs.nix-private.nixosModules.envs.jolteon

    ../../profiles/proxmox.nix

    ../../server/alt-frontends/anonymous-overflow.nix
    ../../server/arr/usenet
    ../../server/development/forgejo
    ../../server/infrastructure/postgresql
    ../../server/services/flaresolverr.nix
    ../../server/services/trmnl-server.nix

    # ../../server/services/webhooks

    # TODO: fix or delete... not a priority atm.
    # Fails during start with: Lucky::ForceSSLHandler was nil, but the setting is required.
    # ../../server/alt-frontends/scribe
  ];

  networking.hostName = "jolteon";

  services = {
    tailscale.extraUpFlags = [
      "--exit-node=100.66.251.23"
      "--exit-node-allow-lan-access=true"
    ];
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
