{inputs, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  # disk = (import ../../hardware/disks).buyvmWithStorage;
  disk = (import ../../hardware/disks).buyvm;
  profile = import ../../profiles/buyvm.nix;
  server = [
    "${inputs.nix-private.outPath}/containers/arr"
    # TODO: debug why this is an issue
    "${inputs.nix-private.outPath}/containers/p2p"
    ../../services/seaweedfs/filer.nix
    ../../services/seaweedfs/volume.nix
  ];
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ server;

  networking.hostName = "eevee";

  # TODO: remove me
  # networking.nat.forwardPorts = [
  #   {
  #     destination = "10.10.80.4:8080";
  #     proto = "tcp";
  #     sourcePort = 8180;
  #   }
  # ];

  # TODO: change this on all servers
  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
  tailscaleUpFlags = [
    # "--accept-routes"
    "--advertise-routes=10.10.0.0/24"
    "--exit-node=de-fra-wg-304.mullvad.ts.net"
    # "--exit-node-allow-lan-access=true"
  ];
}
