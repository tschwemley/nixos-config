{
  inputs,
  config,
  lib,
  pkgs,
  clusterInit ? false,
  enableImpermanence ? true,
  nodeIP,
  role ? "agent",
  ...
}: let
  impermanence =
    if enableImpermanence
    then
      import ../modules/system/impermanence.nix {
        inherit inputs;
        additionalFiles = [
          "/var/lib/rancher/k3s/server/token"
        ];
      }
    else {};
  k3s = import ../modules/services/k3s {
    inherit config lib pkgs clusterInit nodeIP role;
  };
in {
  imports = [
    impermanence
    k3s
    ./server.nix
  ];

  # These are the sops secrets required by every k3s node
  /*
  sops = {
    secrets = {
      root_password = {
        mode = "0440";
        neededForUsers = true;
      };
      user_password = {
        mode = "0440";
        neededForUsers = true;
      };
      wireguard_private = {
        mode = "0644";
        path = "/var/lib/rancher/k3s/wireguard_private";
        owner = config.users.users.systemd-network.name;
        group = config.users.users.systemd-network.group;
        restartUnits = ["systemd-networkd" "systemd-resolved"];
      };
    };
  };
  */
}
