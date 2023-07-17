{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # (pkgs.writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    (writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    k9s
  ];

  # 51820 and 51821 for wg backend
  networking.firewall.allowedUDPPorts = [51820 51821];
  # 10250 for kubelet metrics
  networking.firewall.allowedTCPPorts = [10250];

  programs.zsh.shellAliases = {
    kubectl = "k3s kubectl";
  };

  services.k3s.enable = true;
  sops.secrets.k3s-server-token.sopsFile = ./secrets.yaml;
  systemd.services.k3s = {
    wants = ["containerd.service"];
    after = ["containerd.service" "firewall.service"];
  };

  virtualisation.containerd = {
    enable = true;
    settings = {
      version = 2;
      plugins."io.containerd.grpc.v1.cri" = {
        cni.conf_dir = "/var/lib/rancher/k3s/agent/etc/cni/net.d/";
        # FIXME: upstream
        cni.bin_dir = "${pkgs.runCommand "cni-bin-dir" {} ''
          mkdir -p $out
          ln -sf ${pkgs.cni-plugins}/bin/* ${pkgs.cni-plugin-flannel}/bin/* $out
        ''}";
      };
    };
  };
}
