let
  ip = "127.0.0.1";
in {
  services.nginx.virtualHosts."netbird.schwem.io" = {
    forceSSL = true;
    enableACME = true;
    locations = {
      "/" = {
        proxyPass = "http://${ip}:8180";
        # enableRecommendedProxySettings = true;
      };
      "/signalexchange.SignalExchange/" = {
        extraConfig = ''
          grpc_pass grpc://${ip}:10000;
          grpc_ssl_verify off;
          grpc_read_timeout 1d;
          grpc_send_timeout 1d;
          grpc_socket_keepalive on;
        '';
      };
      "/api/" = {
        proxyPass = "http://${ip}:33073";
        # enableRecommendedProxySettings = true;
      };
      "/management.ManagementService/" = {
        extraConfig = ''
          grpc_pass grpc://${ip}:33073;
          grpc_ssl_verify off;
          grpc_read_timeout 1d;
          grpc_send_timeout 1d;
          grpc_socket_keepalive on;
        '';
      };
    };
  };
}
