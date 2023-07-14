{pkgs, ...}: {
  # 51820 and 51821 for wg backend
  networking.firewall.allowedUDPPorts = [51820 51821];
  # 10250 for kubelet metrics
  networking.firewall.allowedTCPPorts = [10250];
  services.k3s.enable = true;

  environment.systemPackages = with pkgs; [
    # (pkgs.writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    (writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    k9s
  ];

  virtualisation.containerd.enable = true;

  systemd.services.k3s = {
    wants = ["containerd.service"];
    after = ["containerd.service"];
  };

  programs.zsh.shellAliases = {
    kubectl = "k3s kubectl";
  };
}
