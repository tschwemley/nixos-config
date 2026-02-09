{ lib, ... }:
{
  imports = [ ./config.nix ];

  services.sabnzbd = {
    enable = true;
    configFile = null;
  };

  systemd = {
    services.sabznbd = {
      after = [
        "storage.mount"
        "tailscaled.service"
      ];
      wants = [
        "storage.mount"
        "tailscaled.service"
      ];

      preStart = lib.mkForce "";
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

  users.users.sabnzbd.extraGroups = [ "arr" ];
}

/*
    set -euo pipefail

  	declare -a files=(/var/lib/sabnzbd/sabnzbd.ini)

  	tmpfile=$(mktemp)

  	/nix/store/jpz0dz82jyqxfh93dgdlc938jxr67ib6-python3-3.13.11-env/bin/python3.13 \\
  	  /nix/store/jk124ww1dlhqqhg3nfs38q78cqz0frl0-config_merge.py \\
  	  \"\${files[@]}\" \\
  	  > \"$tmpfile\"

  	install -D \\
  	  -m 600 \\
  	  -o 'sabnzbd' -g 'sabnzbd' \\
  	  \"$tmpfile\" \\
  	  /var/lib/sabnzbd/sabnzbd.ini

  	rm \"$tmpfile\"
*/
