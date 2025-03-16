{
  config,
  pkgs,
  ...
}: {
  root = {
    users.users.root.openssh.authorizedKeys.keys = [
      (builtins.readFile ../hosts/${config.networking.hostName}/ssh_key.pub)
    ];

    home-manager.users.root = {
      imports = [
        ../../home/profiles
      ];
      home.homeDirectory = "/root";
    };
  };

  schwem = {
    users.users.schwem = {
      isNormalUser = true;

      extraGroups = [
        config.users.groups.keys.name

        "adbusers"
        "audio"
        "docker"
        "gamemode"
        "networkmanager"
        "plugdev"
        "podman"
        "video"
        "wheel"
        "wireshark"
      ];

      openssh.authorizedKeys.keys = [
        (builtins.readFile ../hosts/${config.networking.hostName}/ssh_key.pub)
      ];

      shell = pkgs.zsh;
    };

    home-manager.users.schwem = {
      imports = [../../home/profiles/pc.nix];

      sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
}
