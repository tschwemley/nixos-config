{
  config,
  lib,
  ...
}: {
  imports = [./.];

  sops.secrets.k3s-server-token.sopsFile = ./secrets.yaml;
  services.k3s.role = "agent";
  # generated random string
  services.k3s.tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
  services.k3s.serverAddr = lib.mkDefault "10.0.0.1:6443";
  # TODO: make this a passable argument or option value
  services.k3s.extraFlags = "--node-ip 10.0.0.2 --container-runtime-endpoint unix:///run/containerd/containerd.sock";
  # services.k3s.extraFlags = "--node-ip ${config.networking.wireguardIp} --container-runtime-endpoint unix:///run/containerd/containerd.sock";
}
