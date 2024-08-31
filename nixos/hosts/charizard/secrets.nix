{
  imports = [./../../../home/secrets/ssh.nix];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/home/schwem/.config/sops/age/keys.txt";
  };
}
