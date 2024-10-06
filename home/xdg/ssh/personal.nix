{ config, ... }:
{
  programs.ssh.matchBlocks = {
    charizard = {
      hostname = "charizard";
      identityFile = config.sops.secrets.charizard_ssh_key.path;
      user = "schwem";
    };
    pikachu = {
      hostname = "pikachu";
      identityFile = config.sops.secrets.pikachu_ssh_key.path;
      user = "schwem";
    };
    personalGithub = {
      host = "gh github.com";
      hostname = "github.com";
      identityFile = config.sops.secrets.personal_gh_key.path;
      user = "git";
    };
  };

  sops.secrets = builtins.listToAttrs (
    map
      (name: {
        inherit name;
        value = {
          sopsFile = ./keys.yaml;
        };
      })
      [
        "charizard_ssh_key"
        "personal_gh_key"
        "pikachu_ssh_key"
      ]
  );
}
