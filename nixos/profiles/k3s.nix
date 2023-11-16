{
  config,
  lib,
  pkgs,
  clusterInit ? false,
  nodeIP,
  role ? "agent",
  ...
}: let
  k3s = import (../modules/services/k3s {
    inherit config lib pkgs clusterInit nodeIP role;
  });
in {
  imports = [
    k3s
    ./server.nix
  ];
}
