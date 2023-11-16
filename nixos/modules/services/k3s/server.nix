{...}: {
  imports = [./.];

  networking.firewall.allowedTCPPorts = [6443];
  services.k3s.extraFlags = "--disable traefik --flannel-backend=wireguard-native --container-runtime-endpoint unix:///run/containerd/containerd.sock";
}
