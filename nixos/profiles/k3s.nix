{
  inputs,
  config,
  lib,
  pkgs,
  clusterInit ? false,
  nodeIP,
  role ? "agent",
  ...
}: let
  impermanence = import ../system/impermanence.nix {
    inherit inputs;
    additionalFiles = [
      "/var/lib/rancher/k3s/server/token"
    ];
  };
  k3s = import ../modules/services/k3s {
    inherit config lib pkgs clusterInit nodeIP role;
  };
in {
  imports = [
    impermanence
    k3s
    ./server.nix
  ];
}
