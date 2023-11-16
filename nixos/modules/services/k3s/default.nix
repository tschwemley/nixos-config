{pkgs, ...}: {
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
}
