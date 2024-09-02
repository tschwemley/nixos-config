{lib, ...}: {
  imports = [./../../../home/secrets/ssh.nix];

  sops = {
    gnupg.sshKeyPaths = lib.mkForce [];
    defaultSopsFile = ./secrets.yaml;
    # age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.sshKeyPaths = lib.mkForce [];
    age.keyFile = lib.mkForce "/home/schwem/.config/sops/age/keys.txt";
  };
}
