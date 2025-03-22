{
  self,
  config,
  ...
}: let
  servers = [
    "articuno"
    "zapados"
    "moltres"
    "jolteon"
    "flareon"
    "tentacool"
  ];

  serverSshConfig = builtins.listToAttrs (
    map
    (name: {
      inherit name;
      value = {
        hostname = name;
        identityFile = config.sops.secrets."${name}_key".path;
        user = "root";
      };
    })
    servers
  );

  serverKeys = builtins.listToAttrs (
    map
    (name: {
      name = "${name}_key";
      value = {
        key = "user_ssh_key";
        sopsFile = ../../../nixos/hosts/${name}/secrets.yaml;
      };
    })
    servers
  );
in {
  imports = [./.];

  programs.ssh = {
    extraConfig = "Include ${config.sops.secrets.extra_work_ssh_config.path}";
    matchBlocks =
      {
        charizard = {
          hostname = "charizard";
          identityFile = config.sops.secrets.charizard_ssh_key.path;
          user = "schwem";
        };

        forgejo = {
          host = "forgejo git.schwem.io";
          hostname = "git.schwem.io";
          identityFile = config.sops.secrets."forgejo_schwem_io_key".path;
          port = 2222;
          user = "forgejo";
        };

        githubZynga = {
          host = "gh-zynga github-ca.corp.zynga.com";
          hostname = "github-ca.corp.zynga.com";
          identityFile = config.sops.secrets.gh_work_key.path;
          proxyJump = "mac";
          user = "git";
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

        mac = {
          # hostname = "192.168.1.69";
          hostname = "192.168.1.12";
          identityFile = config.sops.secrets.mac_key_old.path;
          user = "tschwemley";
          dynamicForwards = [{port = 9876;}];
        };
      }
      // serverSshConfig;
  };

  sops.secrets =
    builtins.listToAttrs (
      map
      (name: {
        inherit name;
        value.sopsFile = "${self.lib.secrets.home}/ssh.yaml";
      })
      [
        "charizard_ssh_key"
        "extra_work_ssh_config"
        "gh_work_key"
        "mac_key"
        "mac_key_old"
        "personal_gh_key"
        "pikachu_ssh_key"
        "forgejo_schwem_io_key"
        "work_server_key"
      ]
    )
    // serverKeys;
}
