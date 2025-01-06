{config, ...}: {
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        security = "user";
      };
      server.string = config.networking.hostName;
      netbios.name = config.networking.hostName;
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts = {
        allow = "192.168.1.0/24 127.0.0.1 localhost";
        deny = "0.0.0.0/0";
      };
      # "guest account" = "nobody";
      # "map to guest" = "bad user";
    };
    shares = {
      shh1 = {
        path = "/storage/shh";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "smb";
        # "force group" = "users";
      };

      shh2 = {
        path = "/storage2/shh";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "smb";
        # "force group" = "users";
      };
    };
  };

  users.users.smb = {
    isNormalUser = true;
    # extraGroups = [
    # ];
  };
}
