{
  self,
  config,
  ...
}:
let
  servers = [
    "articuno"
    "zapdos"
    "moltres"
    "jolteon"
    "flareon"
    "tentacool"
  ];

  serverMatches = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = {
        HostName = name;
        IdentityFile = config.sops.secrets."${name}_key".path;
        User = "root";
      };
    }) servers
  );

  serverKeys = builtins.listToAttrs (
    map (name: {
      name = "${name}_key";
      value = {
        key = "user_ssh_key";
        sopsFile = ../../../nixos/hosts/${name}/secrets.yaml;
      };
    }) servers
  );
in
{
  imports = [ ./. ];

  programs.ssh = {
    includes = [ "${config.sops.secrets.extra_work_ssh_config.path}" ];

    settings = {
      charizard = {
        HostName = "charizard";
        IdentityFile = config.sops.secrets.charizard_ssh_key.path;
        User = "schwem";
      };

      forgejo = {
        Host = "forgejo git.schwem.io";
        HostName = "git.schwem.io";
        IdentityFile = config.sops.secrets."forgejo_schwem_io_key".path;
        Port = 2222;
        User = "forgejo";
      };

      githubZynga = {
        Host = "gh-zynga github-ca.corp.zynga.com";
        HostName = "github-ca.corp.zynga.com";
        IdentityFile = config.sops.secrets.gh_work_key.path;
        ProxyJump = "mac";
        User = "git";
      };

      pikachu = {
        HostName = "pikachu";
        IdentityFile = config.sops.secrets.pikachu_ssh_key.path;
        User = "schwem";
      };

      personalGithub = {
        Host = "gh github.com";
        HostName = "github.com";
        IdentityFile = config.sops.secrets.personal_gh_key.path;
        User = "git";
      };

      mac = {
        HostName = "192.168.1.103";
        IdentityFile = config.sops.secrets.mac_key_old.path;
        User = "tschwemley";

        DynamicForward = "127.0.0.1:9876";
      };
    }
    // serverMatches;
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
