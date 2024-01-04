{
  config,
  lib,
  pkgs,
  nodeIP,
  nodeName,
  role ? "agent",
  ...
}: let
  defaultFlags = "--node-ip ${nodeIP} --node-name ${nodeName} --node-external-ip ${nodeIP} --container-runtime-endpoint unix:///run/containerd/containerd.sock ";
  extraFlags =
    if role == "agent"
    then defaultFlags
    else defaultFlags + "--disable traefik --flannel-backend=wireguard-native --flannel-external-ip --datastore-endpoint=postgres://postgres@10.0.0.1:5432/kubernetes --tls-san=10.0.0.1 --tls-san=10.0.0.2 --tls-san=10.0.0.3";
  serverAddr = "https://10.0.0.1:6443";
in {
  imports =
    if role == "server"
    then [./server.nix]
    else [];

  boot = {
    initrd = {
      availableKernelModules = ["ata_piix" "uhci_hcd" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod" "virtio_blk"];
    };
    kernelModules = ["wireguard"];
    supportedFilesystems = ["btrfs"];
  };

  environment.sessionVariables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    openiscsi
  ];

  # required for wg flannel
  networking = {
    firewall.allowedTCPPorts = [10250];
    firewall.allowedUDPPorts = [51820 51821];
    hostName = nodeName;
  };

  services.k3s = {
    inherit extraFlags role serverAddr;
    enable = true;
    tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
  };

  sops.secrets = {
    k3s-server-token = {
      sopsFile = ./secrets.yaml;
      path = "/var/lib/rancher/k3s/server/token";
    };
  };

  # These are the sops secrets required by every k3s node
  systemd = {
    network.enable = true;

    services = {
      k3s = {
        requires = ["containerd.service" "run-secrets.d.mount" "systemd-networkd.service"];
        after = ["containerd.service" "firewall.service" "run-secrets.d.mount" "systemd-networkd.service"];
      };
      systemd-networkd = {
        requires = ["run-secrets.d.mount"];
        after = ["run-secrets.d.mount"];
      };
    };
  };

  virtualisation.containerd = {
    enable = true;
    settings = {
      version = 2;
      plugins."io.containerd.grpc.v1.cri" = {
        cni.conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
        # TODO: check if this still needs fixed
        # FIXME: upstream
        cni.bin_dir = "${pkgs.runCommand "cni-bin-dir" {} ''
          mkdir -p $out
          ln -sf ${pkgs.cni-plugins}/bin/* ${pkgs.cni-plugin-flannel}/bin/* $out
        ''}";
      };
    };
  };
}
