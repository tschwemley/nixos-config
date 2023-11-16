{...}: {
  imports = [./.];

  networking.firewall.allowedTCPPorts = [6443];
  services.k3s.extraFlags = "--disable traefik --node-external-ip 10.0.0.1 --flannel-backend=wireguard-native --flannel-external-ip --container-runtime-endpoint unix:///run/containerd/containerd.sock";
}
