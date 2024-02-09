let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvmWithStorage;
  services = [
    ../../network
    ../../network/wireguard.nix
    ../../services/syncthing.nix
  ];
  profile = import ../../profiles/server.nix;
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services;

  networking.hostName = "eevee";
  # networking = {
  #   dhcpcd.enable = false;
  #   hostName = nodeName;
  #   firewall.allowedTCPPorts = [51413];
  #   firewall.allowedUDPPorts = [51413];
  # };

  # TODO: change this on all servers
  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/root/.config/sops/age/keys.txt";

    # Specify machine secrets
    secrets = {
      systemd_networkd_10_ens3 = {
        mode = "0444";
        path = "/etc/systemd/network/10-ens3.network";
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
