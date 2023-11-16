{
  config,
  lib,
  ...
}: {
  imports = [./.];

  services.k3s = {
    role = "agent";
    tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
    serverAddr = lib.mkDefault "10.0.0.1`6443";
    extraFlags = "--node-ip 10.0.0.2 --node-external-ip 10.0.0.2 --container-runtime-endpoint unix:///run/containerd/containerd.sock";
  };
}
