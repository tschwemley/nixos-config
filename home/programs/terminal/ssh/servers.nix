{ nixosConfig, ... }:
{
  imports = [ ./. ];

  programs.ssh.settings = {
    forgejo = {
      Host = "forgejo git.schwem.io";
      HostName = "git.schwem.io";
      IdentityFile = nixosConfig.sops.secrets."git.schwem.io.deploy.key".path;
      Port = 2222;
      User = "forgejo";
    };
  };
}
