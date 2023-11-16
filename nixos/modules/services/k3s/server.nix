{
  config,
  lib,
  ...
}: {
  imports = [./.];

  networking.firewall.allowedTCPPorts = [6443];
  services.k3s = {
    role = "server";
    tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
    extraFlags = "--disable traefik --node-ip 10.0.0.1 --node-external-ip 10.0.0.1 --flannel-backend=wireguard-native --flannel-external-ip --container-runtime-endpoint unix:///run/containerd/containerd.sock";
  };
}
