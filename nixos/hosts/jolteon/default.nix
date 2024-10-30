{
  imports = [
    ../../profiles/proxmox.nix

    # server
    ../../server/arr

    ../../server/alt-frontends/anonymous-overflow.nix
    ../../server/alt-frontends/scribe
    ../../server/development/forgejo
    ../../server/infrastructure/postgresql
    ../../server/infrastructure/webhooks
  ];

  networking.hostName = "jolteon";

  services.tailscale.extraUpFlags = [
    "--exit-node=us-chi-wg-007-1.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}
