{
  config,
  pkgs,
  ...
}: let
  schwem = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "audio"
      "docker"
      "wheel"
      "networkmanager"
      config.users.groups.keys.name
    ];
  };
in {
  users.users = {inherit schwem;};
}
