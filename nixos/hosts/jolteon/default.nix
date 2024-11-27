{
  imports = [
    ../../profiles/proxmox.nix

    # server
    ../../server/arr

    ../../server/alt-frontends/anonymous-overflow.nix
    ../../server/development/forgejo
    ../../server/infrastructure/postgresql
    ../../server/infrastructure/webhooks

    # TODO: fix or delete... not a priority atm.
    # Fails during start with: Lucky::ForceSSLHandler was nil, but the setting is required.
    # ../../server/alt-frontends/scribe
  ];

  networking.hostName = "jolteon";

  services.tailscale.extraUpFlags = [
    "--exit-node=100.66.251.23"
    "--exit-node-allow-lan-access=true"
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
