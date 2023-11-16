{pkgs, ...}: {
  environment.systemPackages = with pkgs; [skopeo];

  # server has some additional port requirements:
  # 2379/2389 embedded etcd; 6443 for api server
  networking.firewall.allowedTCPPorts = [
    2379
    2380
    6443
  ];

  programs.zsh.shellAliases = {
    ctr = "k3s ctr";
    kubectl = "k3s kubectl";
  };

  services.k3s.extraFlags = "--disable traefik --flannel-backend=wireguard-native --flannel-external-ip";

  sops.secrets = {
    "schwem.io_github_key" = {
      sopsFile = ./secrets.yaml;
      path = "/root/.ssh/schwem.io-git";
    };
  };
}
