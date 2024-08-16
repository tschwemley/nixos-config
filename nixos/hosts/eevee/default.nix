{inputs, ...}: let
  # boot = (import ../../system/boot.nix).grub "/dev/vda";
  profile = (import ../../profiles/buyvm.nix "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-18810");
  # server = [
  #   "${inputs.nix-private.outPath}/containers/p2p"
  # ];
in {
  imports =
    [
      # boot
      profile
  #   "${inputs.nix-private.outPath}/containers/p2p"
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
    "--exit-node=fr-par-wg-003.mullvad.ts.net"
    "--exit-node-allow-lan-access=true"
  ];
}
