{ pkgs, ... }: {
    services.k3s.enable = true;
	
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "k3s-reset-node" (builtins.readFile ./k3s-reset-node))
    ];

    systemd.services.k3s = {
      wants = [ "containerd.service" ];
      after = [ "containerd.service" ];
    };
}
