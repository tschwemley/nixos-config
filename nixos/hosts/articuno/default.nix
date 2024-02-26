{pkgs, ...}: let
  boot = (import ../../system/boot.nix).grub "/dev/vda";
  disk = (import ../../hardware/disks).buyvm;
  services = [
    ../../network/netbird.nix
    ../../services/coturn
    ../../services/nginx.nix
  ];
  virtualHosts = [
    ../../virtualisation/containers/oci/netbird/virtualhost.nix
    ../../virtualisation/containers/nixos/invidious/virtualhost.nix
    ../../virtualisation/containers/nixos/keycloak/virtualhost.nix
    ../../virtualisation/containers/nixos/searxng/virtualhost.nix
  ];
  profile = import ../../profiles/buyvm.nix;
in {
  imports =
    [
      boot
      disk
      profile
    ]
    ++ services
    ++ virtualHosts;

  environment.systemPackages = with pkgs; [k9s];
  networking.hostName = "articuno";

  #TODO: move this somehwhere more appropriate
  networking.nat.enable = true;
  networking.nat.internalInterfaces = ["ve-searxng"];
  networking.nat.externalInterface = "ens3";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/root/.config/sops/age/keys.txt";
  };

  # read: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion when ready to update
  system.stateVersion = "23.05";
}
