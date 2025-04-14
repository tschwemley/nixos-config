{
  imports = [
    ../../profiles/racknerd.nix

    ../../server/ai/open-webui.nix
    ../../server/alt-frontends/redlib.nix
    ../../server/knowledge/excalidraw

    ../../server/alt-frontends/redlib.nix
    ../../server/alt-frontends/rimgo.nix

    # ../../server/ai/sillytavern.nix
    # ../../server/alt-frontends/scribe
    # ../../server/infrastructure/haproxy
    #../../server/services/searxng

    # ../../../containers/threadfin
  ];

  networking.hostName = "moltres";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.11";

  services.tailscale.extraUpFlags = ["--exit-node=ca-tor-wg-002.mullvad.ts.net"];
}
