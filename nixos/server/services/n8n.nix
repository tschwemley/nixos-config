{
  services.n8n = {
    enable = true;

    # REF: https://docs.n8n.io/hosting/configuration/environment-variables/
    environment = { };

    # TODO: probably will want to enable task runners (should run on host(s) other than n8n host)
    # REF: https://docs.n8n.io/hosting/configuration/task-runners/
    # taskRunners = {
    #   enable = true;
    # };
  };
}
