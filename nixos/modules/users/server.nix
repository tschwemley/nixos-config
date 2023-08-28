{config}: {
  # don't import default since my servers are root-only headless (for now)
  home-manager.users.root.imports = [
    ../../../home/profiles/server.nix
  ];

  users = {
    mutableUsers = false;
    users = {
      root = {
        passwordFile = config.sops.secrets.root_password.path;
        openssh.authorizedKeys.keys = [(builtins.readFile ../../hosts/${config.networking.hostName}/ssh_key.pub)];
      };
    };
  };
}
