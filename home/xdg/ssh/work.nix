{ config, ... }:
{
  imports = [ ./. ];

  programs.ssh.matchBlocks = {
    githubZynga = {
      host = "gh-zynga github-ca.corp.zynga.com";
      hostname = "github-ca.corp.zynga.com";
      identityFile = config.sops.secrets.gh_work_ssh_key.path;
      proxyJump = "mac";
      user = "git";
    };
    mac = {
      hostname = "192.168.1.69";
      identityFile = config.sops.secrets.mac_ssh_key.path;
      user = "tschwemley";
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
        "gh_work_ssh_key"
        "mac_ssh_key"
      ]
  );
}
