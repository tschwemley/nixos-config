{
  config,
  secretsPath,
  ...
}: {
  imports = [./.];

  programs.ssh.matchBlocks = {
    charizard = {
      hostname = "charizard";
      identityFile = config.sops.secrets.charizard_ssh_key.path;
      user = "schwem";
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
      hostname = "192.168.1.69";
      identityFile = config.sops.secrets.mac_key.path;
      user = "tschwemley";
      dynamicForwards = [{port = 9876;}];
    };

    zyngaServer = {
      host = "slots-dev";
      hostname = "slots-dev-vii-02";
      identityFile = config.sops.secrets.work_server_key.path;
      proxyJump = "mac";
      user = "tschwemley";

      localForwards = [
        {
          bind.port = 9095;
          host.address = "localhost";
          host.port = 9095;
        }
      ];
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
      "charizard_ssh_key"
      "gh_work_key"
      "mac_key"
      "personal_gh_key"
      "pikachu_ssh_key"
      "work_server_key"
    ]
  );
}
