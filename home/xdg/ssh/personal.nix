{ osConfig, ... }:
{
  programs.ssh.matchBlocks = {
    charizard = {
      hostname = "charizard";
      # TODO: fill out the IdentityFile portions and create the secrets
      # IdentityFile = osConfig.sops.secrets.charizard_ssh_key.path;
      user = "schwem";
    };
    pikachu = {
      hostname = "pikachu";
      # IdentityFile = osConfig.sops.secrets.pikachu_ssh_key.path;
      user = "schwem";
    };
  };
}
