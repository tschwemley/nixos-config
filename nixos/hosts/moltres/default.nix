{
  inputs,
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: let
  hostName = "moltres";
  k3s = import ../../profiles/k3s.nix {
    inherit inputs config lib pkgs;
    enableImpermanence = false;
    nodeIP = "10.0.0.3";
    role = "server";
  };

  proxmox = import ../../profiles/proxmox.nix {
    inherit config modulesPath;
  };
  user = import ../../modules/users/server.nix {
    inherit config;
    userName = hostName;
  };
in {
  imports = [
    k3s
    proxmox
    user
    # ./wireguard.nix
  ];

  networking.hostName = hostName;

  # TODO: change this for all hosts soon
  services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.05";
}
