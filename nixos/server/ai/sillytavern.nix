{config, ...}: let
  stateDir = "/var/lib/sillytavern";
  user = "sillytavern";
in {
  services.nginx.virtualHosts."sillytavern.schwem.io".

  systemd.tmpfiles.rules = [
    "d ${stateDir}/config 0750 ${user} users - -"
    "d ${stateDir}/data 0750 ${user} users - -"
    "d ${stateDir}/extensions 0750 ${user} users - -"
    "d ${stateDir}/plugins 0750 ${user} users - -"
  ];

  users.users.${user}.isNormalUser = true;

  virtualisation.oci-containers.containers.silly-tavern = {
    autoStart = true;
    image = "ghcr.io/sillytavern/sillytavern:latest";
    podman = {inherit user;};
    ports = ["127.0.0.1:${config.variables.ports.silly-tavern}:8000"];
    pull = "always";
    volumes = [
      "${stateDir}:/home/node/app"
      # "${stateDir}:/home/node/app/config"
      # "${stateDir}/data:/home/node/app/data"
      # "${stateDir}/plugins:/home/node/app/plugins"
    ];
  };
}
