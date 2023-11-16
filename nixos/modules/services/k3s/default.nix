{
  config,
  lib,
  pkgs,
  nodeIP,
  nodeName,
  role ? "agent",
  ...
}: let
  serverAddr = "https://10.0.0.1:6443";
in {
  imports =
    if role == "server"
    then [./server.nix]
    else [];

  environment.sessionVariables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    k9s
  ];

  # required for wg flannel
  networking.firewall.allowedUDPPorts = [51820 51821];
  # 10250 for kubelet metrics
  networking.firewall.allowedTCPPorts = [10250];

  services.k3s = {
    inherit role serverAddr;
    enable = true;
    extraFlags = "--node-ip ${nodeIP} --node-name ${nodeName} --node-external-ip ${nodeIP} --container-runtime-endpoint unix:///run/containerd/containerd.sock ";
    tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
  };

  sops.secrets = {
    k3s-server-token = {
      sopsFile = ./secrets.yaml;
      path = "/var/lib/rancher/k3s/server/token";
    };
  };

  systemd.services = {
    k3s = {
      requires = ["containerd.service" "run-secrets.d.mount" "systemd-networkd.service"];
      after = ["containerd.service" "firewall.service" "run-secrets.d.mount" "systemd-networkd.service"];
    };
    systemd-networkd = {
      requires = ["run-secrets.d.mount"];
      after = ["run-secrets.d.mount"];
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
