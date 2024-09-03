{
  imports = [./../../../home/secrets/ssh.nix];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = [];
    age.keyFile = "/home/schwem/.config/sops/age/keys.txt";
    gnupg.sshKeyPaths = [];
  };
}
