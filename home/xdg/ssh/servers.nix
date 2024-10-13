{ config, ... }:
{
  imports = [ ./. ];

  programs.ssh.matchBlocks =
    builtins.listToAttrs (
      map
        (name: {
          inherit name;
          value = {
            hostname = name;
            identityFile = config.sops.secrets."${name}_key".path;
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
    zapados_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/zapados/secrets.yaml;
    };
    moltres_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/moltres/secrets.yaml;
    };
    eevee_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/eevee/secrets.yaml;
    };
    jolteon_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/jolteon/secrets.yaml;
    };
    flareon_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/flareon/secrets.yaml;
    };
    tentacool_key = {
      key = "user_ssh_key";
      sopsFile = ../../../nixos/hosts/tentacool/secrets.yaml;
    };

    forgejo_schwem_io_key = {
      sopsFile = ./keys.yaml;
    };
  };
}
