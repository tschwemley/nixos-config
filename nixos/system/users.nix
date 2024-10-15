{
  config,
  pkgs,
  ...
}:
{
  root = {
    users.users.root.openssh.authorizedKeys.keys = [
      (builtins.readFile ../hosts/${config.networking.hostName}/ssh_key.pub)
    ];

    home-manager.users.root = {
      imports = [ ../../home/profiles ];
      home.homeDirectory = "/root";
      # TODO: switch age key file over to /etc?
      # sops.age.keyFile = "/etc/sops/age-keys.txt";
      sops.age.keyFile = "/root/.config/sops/age/keys.txt";
    };
  };

  schwem = {
    users.users.schwem = {
      isNormalUser = true;

      extraGroups = [
        config.users.groups.keys.name

        "audio"
        "docker"
        "gamemode"
        "networkmanager"
        "plugdev"
        "podman"
        "wheel"
      ];

      openssh.authorizedKeys.keys = [
        (builtins.readFile ../hosts/${config.networking.hostName}/ssh_key.pub)
      ];

      shell = pkgs.zsh;
    };

    home-manager.users.schwem = {
      imports = [ ../../home/profiles/pc.nix ];

      sops.age.keyFile = "/home/schwem/.config/sops/age/keys.txt";
      systemd.user.settings.Manager.DefaultLimitNOFILE = "524288";
    };
  };
}
