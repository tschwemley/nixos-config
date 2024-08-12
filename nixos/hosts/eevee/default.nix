{inputs, ...}: let
  boot = (import ../../system/boot.nix).systemd;
  profile = (import ../../profiles/buyvm.nix "/dev/by-id/scsi-0BUYVM_SLAB_VOLUME-18810");
  # server = [
  #   "${inputs.nix-private.outPath}/containers/p2p"
  # ];
in {
  imports =
    [
      boot
      profile
    ];
    # ++ server;

  networking.hostName = "eevee";

  # TODO: change this on all servers
  services.getty.autologinUser = "root";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";

  tailscaleUpFlags = [
    "--exit-node=100.76.46.81"
    "--exit-node-allow-lan-access=true"
  ];
}
