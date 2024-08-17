{
  networking.firewall.allowedTCPPorts = [8080];

  services.nginx = {
    enable = true;
    defaultListen = [
      {
        addr = "0.0.0.0";
        port = 8080;
        proxyProtocol = true;
      }
    ];
    recommendedProxySettings = true;
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

  users.users.nginx.extraGroups = ["users"];
}
