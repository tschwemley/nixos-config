{
  self,
  config,
  ...
}: {
  imports = [./.];

  programs.ssh.matchBlocks = {
    forgejo = {
      host = "forgejo git.schwem.io";
      hostname = "git.schwem.io";
      identityFile = config.sops.secrets."git.schwem.io.deploy.key".path;
      port = 2222;
      user = "forgejo";
    };
  };

  sops.secrets = {
    "git.schwem.io.deploy.key" = {
      sopsFile = "${self.lib.secrets.nixos}/ssh.yaml";
      mode = "0600";
    };
  };
}
