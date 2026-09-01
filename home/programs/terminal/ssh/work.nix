{
  self,
  config,
  ...
}: {
  imports = [./.];

  programs.ssh.matchBlocks = {
    gh = {
      hostname = "github.com";
      identityFile = config.sops.secrets.gh_personal_zynga_key.path;
      user = "git";
    };
  };

  sops.secrets = builtins.listToAttrs (
    map
    (name: {
      inherit name;
      value = {
        sopsFile = "${self.lib.secrets.home}/ssh.yaml";
      };
    })
    [
      "gh_personal_zynga_key"
      "gh_work_key"
      "work_server_key"
    ]
  );
}
