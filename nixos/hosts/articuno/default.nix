{
  inputs,
  config,
  modulesPath,
  ...
}: let
  hostName = "articuno";
  profile = (import ../profiles/proxmox.nix {
      inherit config;
      profile = "k3s"; 
      extraImports = ["../../modules/services/k3s/server.nix"];
    });
  # impermanence = import ../../modules/system/impermanence.nix {inherit inputs;};
  # user = import ../../modules/users/server.nix {
  #   inherit config;
  #   userName = hostName;
  # };
in {
  imports = [
    profile
    #impermanence
    # user
    # ./wireguard.nix
    # ../../modules/services/k3s/server.nix
    # ../../profiles/k3s.nix
  ];

  networking.hostName = hostName;
# TODO: determine if this is needed for qemu
  #services.getty.autologinUser = "root";

  # don't update this
  system.stateVersion = "23.11";
}
