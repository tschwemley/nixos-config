{
  sops.secrets = {
    "articuno_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/articuno";
      sopsFile = ./../../nixos/hosts/articuno/secrets.yaml;
    };
    "eevee_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/eevee";
      sopsFile = ./../../nixos/hosts/eevee/secrets.yaml;
    };
    "flareon_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/flareon";
      sopsFile = ./../../nixos/hosts/flareon/secrets.yaml;
    };
    "jolteon_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/jolteon";
      sopsFile = ./../../nixos/hosts/jolteon/secrets.yaml;
    };
    "gh_key" = {
      key = "gh_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/github_key";
      sopsFile = ./ssh.yaml;
    };
    "gh_work_key" = {
      key = "gh_work_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/github_work_key";
      sopsFile = ./ssh.yaml;
    };
    "mac_key" = {
      key = "mac_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/mac_ssh_key";
      sopsFile = ./ssh.yaml;
    };
    "media_key" = {
      key = "media_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/media";
      sopsFile = ./ssh.yaml;
    };
    "moltres_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/moltres";
      sopsFile = ./../../nixos/hosts/moltres/secrets.yaml;
    };
    "pikachu_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/pikachu";
      sopsFile = ./../../nixos/hosts/pikachu/secrets.yaml;
    };
    "tentacool_key" = {
      key = "user_ssh_key";
      owner = "schwem";
      path = "/home/schwem/.ssh/tentacool";
      sopsFile = ./../../nixos/hosts/tentacool/secrets.yaml;
    };
    "ssh_config" = {
      mode = "0600";
      owner = "schwem";
      path = "/home/schwem/.ssh/config";
      sopsFile = ./ssh.yaml;
    };
  };
}
