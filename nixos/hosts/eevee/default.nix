{inputs, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  # disk = (import ../../hardware/disks).buyvmWithStorage;
  disk = (import ../../hardware/disks).buyvm;
  profile = import ../../profiles/buyvm.nix;
  server = [
    # "${inputs.nix-private.outPath}/containers/arr"
    # "${inputs.nix-private.outPath}/containers/p2p"
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

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.all.forwarding" = 1;
    # On WAN, allow IPv6 autoconfiguration and tempory address use.
    "net.ipv6.conf.ens3.accept_ra" = 2;
    "net.ipv6.conf.ens3.autoconf" = 1;
  };

  networking.hostName = "eevee";
  networking.interfaces.ve-sabnzbd.mtu = 1200;

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
    "--advertise-routes=10.250.0.0/24"
    "--exit-node=100.76.46.81"
    "--exit-node-allow-lan-access=true"
    # "--snat-subnet-routes=false"
  ];
}
