{nixosConfig, ...}: {
  imports = [./.];

  programs.ssh.matchBlocks = {
    forgejo = {
      host = "forgejo git.schwem.io";
      hostname = "git.schwem.io";
      identityFile = nixosConfig.sops.secrets."git.schwem.io.deploy.key".path;
      port = 2222;
      user = "forgejo";
    };
  };
}
