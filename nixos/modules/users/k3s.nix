{
  users.users = {
    k3s = {
      isNormalUser = true;
      home = "/home/k3s";
      extraGroups = [ "wheel" "k3s" ];
      # uid = 1000;
      # openssh.authorizedKeys.keys = keys;
    };

    # root.openssh.authorizedKeys.keys = keys;
  };

  # home-manager.users.k3s = import ../../../home-manager/profiles/server.nix

  # boot.initrd.network.ssh.authorizedKeys = keys;
  # security.sudo.wheelNeedsPassword = false;

  # imports = [ ./zsh.nix ];
}
