{
  config,
  homeConfigurations,
  ...
}: {
  imports = [./.];

  users.users = {
    schwem = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" config.users.groups.keys.name];
    };
  };

  home-manager.users.schwem = {
    imports = [
      ../../../home/profiles/pc.nix
    ];

    sops = {
      age.keyFile = "/home/schwem/.config/"; # must have no password!
      defaultSopsFile = config.sops.defaultSopsFile;
      secrets.bw_email = {
        # %r gets replaced with a runtime directory ($XDG_RUNTIME_DIR)
        path = "%r/bw_email";
      };
    };
  };
}
