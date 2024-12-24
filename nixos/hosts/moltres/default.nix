{
  imports = [
    (import ../../profiles/buyvm.nix "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-25377")

    # server imports
    ../../../containers/excalidraw

    ../../server/alt-frontends/freetar.nix
    ../../server/alt-frontends/redlib.nix
    ../../server/alt-frontends/rimgo.nix
    ../../server/services/searxng

    # ../../../containers/threadfin
  ];

  # TODO: remove this after testing vps
  services.nginx.virtualHosts."redlib.schwem.io" = {
    locations."/" = {
      proxyPass = "http://127.0.0.1:8180";
    };
  };

  networking.hostName = "moltres";

  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";

  services.tailscale.extraUpFlags = [
    "--exit-node=us-mia-wg-003.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
  ];
}
