{
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/home/schwem/.config/sops/age/keys.txt";

    # these are all user secrets. might be better to use home-manager but idgaf right now
    secrets = {
      "articuno_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/articuno";
        sopsFile = ./../articuno/secrets.yaml;
      };
      "bw_email" = {
        owner = "schwem";
      };
      "eevee_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/eevee";
        sopsFile = ./../eevee/secrets.yaml;
      };
      "flareon_key" = {
        key = "ssh_private_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/flareon";
        sopsFile = ./../flareon/secrets.yaml;
      };
      "jolteon_key" = {
        key = "user_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/jolteon";
        sopsFile = ./../jolteon/secrets.yaml;
      };
      "gh_key" = {
        key = "gh_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/github_key";
      };
      "gh_work_key" = {
        key = "gh_work_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/github_work_key";
      };
      "mac_key" = {
        key = "mac_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/mac_ssh_key";
      };
      "moltres_key" = {
        key = "user_ssh_key";
        owner = "schwem";
        path = "/home/schwem/.ssh/moltres";
        sopsFile = ./../moltres/secrets.yaml;
      };
      "openweather_api_key" = {
        key = "openweather_api_key";
        owner = "schwem";
        path = "/home/schwem/.config/.openweather-api-key";
      };
      "openweather_city_id" = {
        key = "openweather_city_id";
        owner = "schwem";
        path = "/home/schwem/.config/.openweather-city-id";
      };
      "ssh_config" = {
        mode = "0600";
        owner = "schwem";
        path = "/home/schwem/.ssh/config";
      };
    };
  };
}
