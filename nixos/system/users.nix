{
  config,
  pkgs,
  ...
}:
let
  schwem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "docker"
      "gamemode"
      "networkmanager"
      "plugdev"
      "podman"
      "wheel"
      config.users.groups.keys.name
    ];
  };
in
{
  root = {
    users.users.root.openssh.authorizedKeys.keys = [
      (builtins.readFile ../hosts/${config.networking.hostName}/ssh_key.pub)
    ];
    home-manager.users.root.imports = [ ../../home/profiles ];
  };
  schwem = {
    users.users = {
      inherit schwem;
    };
    home-manager.users.schwem = {
      imports = [ ../../home/profiles/pc.nix ];
      systemd.user.settings.Manager.DefaultLimitNOFILE = "524288";
    };
  };
}
