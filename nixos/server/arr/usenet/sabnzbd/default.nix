{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./config.nix ];

  systemd = {
    services.sabnzbd = {
      description = "sabnzbd server";
      wantedBy = [ "multi-user.target" ];

      after = [
        "storage.mount"
        "network.target"
        "tailscaled.service"
      ];

      serviceConfig =
        let
          iniPathQuoted = lib.escapeShellArg config.sops.templates."sabnzbd.ini".path;
        in
        {
          Type = "forking";
          GuessMainPID = "no";
          User = "sabnzbd";
          Group = "sabnzbd";
          StateDirectory = "/var/lib/sabnzbd";
          ExecStart = "${lib.getExe pkgs.sabnzbd} -d -f ${iniPathQuoted}";
        };

      # preStart = "";
    };

    tmpfiles = {
      rules = [
        "d /storage/downloads/complete 0770 sabznbd arr - -"
        "d /storage/downloads/incomplete 0770 sabznbd arr - -"

        "d /var/lib/sabnzbd 0760 sabznbd sabnzbd - -"
        "C+ /var/lib/sabnzbd/scripts/post-process 0755 sabnzbd sabnzbd - ${./post-process}"
      ];
    };
  };

  users = {
    groups.sabnzbd = { };
    users.sabnzbd = {
      isSystemUser = true;
      description = "sabnzbd user";

      extraGroups = [ "arr" ];
      group = "sabnzbd";
    };
  };
}
