{
  config,
  lib,
  pkgs,
  clusterInit,
  nodeIP,
  role ? "agent",
  ...
}: let
  defaultFlags = "--node-ip ${nodeIP} --node-external-ip ${nodeIP} --container-runtime-endpoint unix:///run/containerd/containerd.sock ";
  serverFlags = "--disable traefik --flannel-backend=wireguard-native --flannel-external-ip";

  extraFlags =
    defaultFlags
    + (
      if role == "server"
      then serverFlags
      else ""
    );
  serverAddr =
    if !clusterInit
    then "https://10.0.0.1:6443"
    else "";
in {
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    k9s
  ];

  # 51820 and 51821 for wg backend
  networking.firewall.allowedUDPPorts = [51820 51821];
  # 6443 for api server; 10250 for kubelet metrics
  networking.firewall.allowedTCPPorts = [10250 (lib.mkIf clusterInit 6443)];

  programs.zsh.shellAliases = {
    ctr = "k3s ctr";
    kubectl = "k3s kubectl";
  };

  services.k3s = {
    inherit clusterInit extraFlags role serverAddr;
    enable = true;
#tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
    tokenFile = "/var/lib/rancher/k3s/server/token";
  };

#sops.secrets.k3s-server-token.sopsFile = ./secrets.yaml;
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
