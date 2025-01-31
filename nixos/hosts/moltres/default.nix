{
  imports = [
    ../../profiles/racknerd.nix

    ../../../containers/excalidraw
    ../../server/alt-frontends/redlib.nix
    ../../server/infrastructure/haproxy

    #../../server/alt-frontends/freetar.nix
    #../../server/alt-frontends/rimgo.nix
    # ../../server/alt-frontends/scribe
    #../../server/services/searxng

    # ../../../containers/threadfin
  ];

  # TODO: remove this after testing vps
  services.nginx.virtualHosts."redlib.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8180";
    };
  };

  networking.hostName = "moltres";

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "24.11";

  services.tailscale.extraUpFlags = ["--exit-node=ca-tor-wg-002.mullvad.ts.net"];
}
