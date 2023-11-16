{ pkgs, ... }:
{
    services.k3s.enable = true; 
    # services.k3s.tokenFile = lib.mkDefault config.sops.secrets.k3s-server-token.path;
    # services.k3s.serverAddr = lib.mkDefault "https://astrid.dse.in.tum.de:6443";
    # services.k3s.extraFlags = "--node-ip ${config.networking.doctorwho.currentHost.ipv4} --snapshotter=zfs --container-runtime-endpoint unix:///run/containerd/containerd.sock";
    
    networking.firewall.allowedTCPPorts = [ 6443 ];
    environment.systemPackages = with pkgs; [
        k3s
        k9s
    ]; 
}
