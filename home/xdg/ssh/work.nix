{ config, ... }:
{
  imports = [ ./. ];

  programs.ssh.matchBlocks = {
    githubZynga = {
      host = "gh-zynga github-ca.corp.zynga.com";
      hostname = "github-ca.corp.zynga.com";
      identityFile = config.sops.secrets.gh_work_key.path;
      proxyJump = "mac";
      user = "git";
    };
    mac = {
      hostname = "192.168.1.69";
      identityFile = config.sops.secrets.mac_key.path;
      user = "tschwemley";
    };
    zyngaServer = {
      host = "slots-dev";
      hostname = "slots-dev-vii-02";
      identityFile = config.sops.secrets.work_server_key.path;
      proxyJump = "mac";
      user = "tschwemley";
    };
  };

  sops.secrets = builtins.listToAttrs (
    map
      (name: {
        inherit name;
        value = {
          sopsFile = ../../../secrets/home/ssh.yaml;
        };
      })
      [
        "gh_work_key"
        "mac_key"
        "work_server_key"
      ]
  );
}
