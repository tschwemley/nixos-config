{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  diskName = "/dev/nvme1n1";
  diskConfig = {
    imports = [
      (import ../../modules/hardware/disks/btrfs-encrypted.nix {inherit diskName;})
    ];
  };

  boot = import ../../modules/system/systemd-boot.nix;
  hardware = {
    imports = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      inputs.nixos-hardware.nixosModules.common-gpu-amd
      inputs.nixos-hardware.nixosModules.common-pc
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      # TODO: move this to it's own module
      {
        hardware.enableRedistributableFirmware = true;
        # TODO: determine if this makes any difference
        systemd.tmpfiles.rules = [
          "L+   /opt/rocm/hip  -  -  -  -  ${pkgs.hip}"
        ];
      }
    ];
  };
in {
  imports = [
    boot
    diskConfig
    hardware
    ../../profiles/pc.nix
    ../../modules/users/schwem.nix
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "uas" "sd_mod"];
      kernelModules = ["kvm-intel"];
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["btrfs"];
  };

  services.openssh = {
    enable = true;
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  networking = {
    hostName = "charizard";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };

  services.getty.autologinUser = "schwem";

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/home/schwem/.config/sops/age/keys.txt";

    # these are all user secrets. might be better to use home-manager but idgaf right now
    secrets = {
      "articuno_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/articuno";
        sopsFile = ./../articuno/secrets.yaml;
      };
      "bw_email" = {
        owner = "schwem";
      };
      "eevee_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/eevee";
        sopsFile = ./../eevee/secrets.yaml;
      };
      "gh_key" = {
        key = "gh_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/github_key";
      };
      "mac_key" = {
        key = "mac_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/mac_ssh_key";
      };
      "ssh_config" = {
        mode = "0600";
        owner = "schwem";
        path = "/home/schwem/.ssh/config";
      };
    };
  };

  # TODO: pretty sure polkit is necessary for home-manager config of wayland; confirm
  # security.polkit.enable = true;

  system.autoUpgrade.enable = true;
  # don't update this
  system.stateVersion = "23.05";

  time.timeZone = "America/Detroit";

  users = {
    mutableUsers = true; # allow mutable users on non-servers
    # users.schwem.passwordFile = config.sops.secrets.schwem_user_password.path;
  };
}
