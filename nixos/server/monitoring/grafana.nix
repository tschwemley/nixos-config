# TODO: setup w/ cockroachdb. By default it's using sqlite
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
      };
    };
  };
}
