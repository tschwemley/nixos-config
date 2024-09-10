{
  sops.secrets = {
    searxng_secret = {
      sopsFile = ./secrets.yaml;
    };
    searxng_env_file = {
      sopsFile = ./secrets.yaml;
    };
  };
}
