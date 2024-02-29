{
  config,
  pkgs,
  ...
}: let
  hostname = "ldap.schwem.io";
in {
  services.openldap = {
    enable = true;
    urlList = ["ldap:///" "ldaps:///"];

    settings = {
      attrs = {
        olcLogLevel = "conns config";

        /*
        settings for acme ssl
        */
        olcTLSCACertificateFile = "/var/lib/acme/${hostname}/full.pem";
        olcTLSCertificateFile = "/var/lib/acme/${hostname}/cert.pem";
        olcTLSCertificateKeyFile = "/var/lib/acme/${hostname}/key.pem";
        olcTLSCipherSuite = "HIGH:MEDIUM:+3DES:+RC4:+aNULL";
        olcTLSCRLCheck = "none";
        olcTLSVerifyClient = "never";
        olcTLSProtocolMin = "3.1";
      };

      children = {
        "cn=schema".includes = [
          "${pkgs.openldap}/etc/schema/core.ldif"
          "${pkgs.openldap}/etc/schema/cosine.ldif"
          "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
        ];

        "olcDatabase={1}mdb".attrs = rec {
          objectClass = ["olcDatabaseConfig" "olcMdbConfig"];

          olcDatabase = "{1}mdb";
          olcDbDirectory = "/var/lib/openldap/data";

          olcSuffix = "dc=schwem,dc=io";

          /*
          your admin account, do not use writeText on a production system
          */
          olcRootDN = "cn=admin,${olcSuffix}";
          olcRootPW.path = config.sops.secrets.adminPassword.path;
          # olcRootPW.path = pkgs.writeText "olcRootPW" "pass";

          olcAccess = [
            /*
            custom access rules for userPassword attributes
            */
            ''              {0}to attrs=userPassword
                              by self write
                              by anonymous auth
                              by * none''

            /*
            allow read on anything else
            */
            ''              {1}to *
                              by * read''
          ];
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;

    /*
    trigger the actual certificate generation for your hostname
    */
    certs."${hostname}" = {
      extraDomainNames = [];
    };

    defaults = {
      credentialsFile = config.sops.secrets.dnsApiKey.path;
      dnsProvider = "cloudflare";
      email = "automation@schwem.io";
      group = "certs";
    };
  };

  /*
  ensure openldap is launched after certificates are created
  */
  systemd.services.openldap = {
    wants = ["acme-${hostname}.service"];
    after = ["acme-${hostname}.service"];
  };

  sops.secrets = let
    mode = "0444";
  in {
    adminPassword = {
      inherit mode;
      sopsFile = ./secrets.yaml;
    };
    dnsApiKey = {
      inherit mode;
      sopsFile = ../acme/secrets.yaml;
    };
  };

  /*
  make acme certificates accessible by openldap
  */
  users.groups.certs.members = ["openldap"];
}
