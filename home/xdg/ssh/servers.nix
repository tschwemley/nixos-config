{ config, ... }:
{
  programs.ssh.matchBlocks =
    builtins.listToAttrs (
      map
        (name: {
          inherit name;
          value = {
            hostname = name;
            user = "root";
          };
        })
        [
          "articuno"
          "zapados"
          "moltres"
          "eevee"
          "jolteon"
          "flareon"
          "tentacool"
        ]
    )
    // {
      forgejo = {
        host = "forgejo git.schwem.io";
        hostname = "git.schwem.io";
        identityFile = config.sops.secrets.forgejo_schwem_io_key.path;
        port = 2222;
        user = "forgejo";
      };
    };

  sops.secrets = {
    articuno_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/articuno/secrets.yaml;
    };

    forgejo_schwem_io_key = {
      sopsFile = ./keys.yaml;
    };
  };
}
