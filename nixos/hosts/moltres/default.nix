{
  imports = [
    ../../profiles/racknerd.nix

    ../../server/alt-frontends/freetar.nix
    ../../server/knowledge/excalidraw
    ../../server/infrastructure/haproxy
    ../../server/services/open-webui.nix

    # TODO: decide if this will be one of the servers to load balance redlib on
    # ../../server/alt-frontends/redlib.nix

    #../../server/alt-frontends/rimgo.nix
    # ../../server/alt-frontends/scribe
    #../../server/services/searxng

    # ../../../containers/threadfin
  ];

  networking.hostName = "moltres";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.11";

  services.tailscale.extraUpFlags = ["--exit-node=ca-tor-wg-002.mullvad.ts.net"];
}
