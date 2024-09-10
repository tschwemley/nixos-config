{
  networking.firewall.allowedTCPPorts = [ 8080 ];

  services.nginx = {
    enable = true;

    defaultListen = [
      {
        addr = "0.0.0.0";
        port = 8080;
        proxyProtocol = true;
      }
    ];

    # see source for more information on what these values set: 
    #  https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/services/web-servers/nginx/default.nix
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    tailscaleAuth = {
      enable = true;
      expectedTailnet = "wyvern-map.ts.net";
      virtualHosts = [
        "monitor.schwem.io"
        "threadfin.schwem.io"
      ];
    };
  };

  # sops.secrets.nginx_allow_secure = {
  #   sopsFile = ./secrets.yaml;
  # };
  #
  # sops.templates.nginx_allow_secure = {
  #   content = ''
  #     ${config.sops.placeholder.nginx_allow_secure}
  #     deny all;
  #   '';
  #   group = "nginx";
  #   owner = "nginx";
  # };

  users.users.nginx.extraGroups = [ "users" ];
}
