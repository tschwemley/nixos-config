{inputs, ...}: {
  imports = [
    (import ../../profiles/buyvm.nix "/dev/disk/by-id/scsi-0BUYVM_SLAB_VOLUME-18810")

    # server imports
    "${inputs.nix-private.outPath}/containers/p2p"
  ];

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
    "--exit-node=100.89.145.107"
    "--exit-node-allow-lan-access=true"
  ];
}
