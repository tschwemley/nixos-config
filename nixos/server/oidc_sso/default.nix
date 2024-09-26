{
  config,
  inputs,
  pkgs,
  ...
}:
let
  pkg = inputs.server-oidc-sso.packages.${pkgs.system}.default;
in
{
  systemd.services.oidc-sso = {
    enable = true;
    serviceConfig = {
      Type = "simple";
      User = "oidc-sso";
      Group = "oidc-sso";

      ExecStart = "${pkg}/bin/oidc-sso";
      EnvironmentFile = config.sops.secrets.oidc-sso_env.path;
      WorkingDirectory = "/var/lib/oidc-sso";
      StateDirectory = "oidc-sso";
      SyslogIdentifier = "oidc-sso";
    };

    description = "oidc-sso";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
  };

  sops.secrets.oidc-sso_env = {
    sopsFile = ./.env;
  };

  users = {
    groups.oidc-sso = { };
    users.oidc-sso = {
      group = "oidc-sso";
      isSystemUser = true;
    };
  };
}
