{
  self,
  config,
  pkgs,
  ...
}: {
  root = {
    users.users.root.openssh.authorizedKeys.keys = [
      (builtins.readFile ../hosts/${config.networking.hostName}/ssh_key.pub)
    ];

    home-manager.users.root = {
      imports =
        [
          ../../home/profiles
        ]
        ++ (
          if self.lib.isServer config.networking.hostName
          then [../../home/xdg/ssh/servers.nix]
          else []
        );
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
        "dialout"
        "docker"
        "gamemode"
        "networkmanager"
        "plugdev"
        "podman"
        "render"
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
