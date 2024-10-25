{ config, secretsPath, ... }:
{
  imports = [ ./. ];

  programs.ssh.matchBlocks = {
    gh = {
      hostname = "github.com";
      identityFile = config.sops.secrets.gh_personal_zynga_key.path;
      proxyJump = "mac";
      user = "git";
    };
    githubZynga = {
      host = "gh-zynga github-ca.corp.zynga.com";
      hostname = "github-ca.corp.zynga.com";
      identityFile = config.sops.secrets.gh_work_key.path;
      user = "git";
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
          sopsFile = "${secretsPath}/home/ssh.yaml";
        };
      })
      [
        "gh_personal_zynga_key"
        "gh_work_key"
        "work_server_key"
      ]
  );
}
