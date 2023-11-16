{
  config,
  lib,
  nodeIp,
  ...
}: {
  imports = [./.];

  sops.secrets.k3s-server-token.sopsFile = ./secrets.yaml;
  services.k3s.role = "agent";
  # generated random string
  services.k3s.tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
  services.k3s.serverAddr = lib.mkDefault "10.0.0.1:6443";
  services.k3s.extraFlags = "--node-ip ${nodeIp} --container-runtime-endpoint unix:///run/containerd/containerd.sock";
}
