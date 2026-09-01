{
  imports = [
    ../../profiles/racknerd.nix

    ../../server/alt-frontends/redlib.nix
    ../../server/alt-frontends/rimgo.nix
    ../../server/media/audiobookshelf.nix
    ../../server/security/anubis.nix

    # ../../server/alt-frontends/scribe
    # ../../server/infrastructure/haproxy
    # ../../server/services/anki-sync.nix
    # ../../server/services/pds.nix
  ];

  networking.hostName = "moltres";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.11";

  services.tailscale.extraUpFlags = [ "--exit-node=ca-tor-wg-002.mullvad.ts.net" ];
}
