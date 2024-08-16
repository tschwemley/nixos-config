{
  imports = [
    ../../profiles/proxmox.nix

    # server imports
    ../../server/cockroachdb
  ];

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion/ when ready to update
  system.stateVersion = "23.05";
}

/*
{inputs, ...}: let
  boot = (import ../../system/boot.nix).systemd;
  disk = (import ../../hardware/disks).proxmox;
  profile = import ../../profiles/proxmox.nix;
  server = [
    "${inputs.nix-private.outPath}/containers/excalidraw"
    # ../../../containers/redlib
    # ../../services/seaweedfs/volume.nix
    # ../../server/monitoring/prometheus/node-exporter.nix
    ../../server/nginx
    # ../../server/sourcehut
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

  networking.hostName = "zapados";
  sops.defaultSopsFile = ./secrets.yaml;

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
*/
