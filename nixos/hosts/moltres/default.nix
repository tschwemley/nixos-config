{
  imports = [
    ../../profiles/racknerd.nix

    ../../server/alt-frontends/redlib.nix
    ../../server/alt-frontends/rimgo.nix
    ../../server/knowledge/excalidraw
    ../../server/security/anubis.nix
    # ../../server/services/pds.nix

    # ../../server/ai/librechat
    # ../../server/ai/sillytavern.nix
    # ../../server/alt-frontends/scribe
    # ../../server/infrastructure/haproxy
    # ../../server/services/anki-sync.nix
    # ../../server/services/taskchampion-sync-server.nix
  ];

  networking.hostName = "moltres";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.11";

  services.tailscale.extraUpFlags = [ "--exit-node=ca-tor-wg-002.mullvad.ts.net" ];
}
