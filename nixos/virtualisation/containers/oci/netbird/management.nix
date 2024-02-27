{config, ...}: {
  sops.templates.netbirdMgmtConfig.content = builtins.toJSON {
    Stuns = [
      {
        Proto = "udp";
        URI = "stun:netbird.schwem.io:3478";
        Username = "";
        Password = null;
      }
    ];
    TURNConfig = {
      Turns = [
        {
          Proto = "udp";
          URI = "turn:netbird.schwem.io:3478";
          Username = "self";
          Password = "";
        }
      ];
      CredentialsTTL = "12h";
      Secret = "secret";
      TimeBasedCredentials = false;
    };
    Signal = {
      Proto = "http";
      URI = "netbird.schwem.io";
      # URI = "0.0.0.0:10000";
      Username = "";
      Password = null;
    };
    Datadir = "";
    DataStoreEncryptionKey = "";
    StoreConfig = {
      Engine = "jsonfile";
    };
    HttpConfig = {
      Address = "netbird.schwem.io";
      AuthIssuer = "https://auth.schwem.io/realms/netbird";
      AuthAudience = "netbird";
      AuthKeysLocation = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/certs";
      AuthUserIDClaim = "";
      CertFile = "";
      CertKey = "";
      IdpSignKeyRefreshEnabled = false;
      OIDCConfigEndpoint = "https://auth.schwem.io/realms/netbird/.well-known/openid-configuration";
    };
    IdpManagerConfig = {
      ManagerType = "keycloak";
      ClientConfig = {
        Issuer = "https://auth.schwem.io/realms/netbird";
        TokenEndpoint = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/token";
        ClientID = "netbird-backend";
        ClientSecret = config.sops.placeholder.netbirdBackendSecret;
        GrantType = "client_credentials";
      };
      ExtraConfig = {
        AdminEndpoint = "https://auth.schwem.io/admin/realms/netbird";
      };
      Auth0ClientCredentials = null;
      AzureClientCredentials = null;
      KeycloakClientCredentials = null;
      ZitadelClientCredentials = null;
    };
    DeviceAuthorizationFlow = {
      Provider = "hosted";
      ProviderConfig = {
        Audience = "netbird";
        AuthorizationEndpoint = "";
        Domain = "";
        ClientID = "netbird-client";
        ClientSecret = "";
        TokenEndpoint = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/token";
        DeviceAuthEndpoint = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/auth/device";
        Scope = "openid";
        UseIDToken = false;
        RedirectURLs = null;
      };
    };
    PKCEAuthorizationFlow = {
      ProviderConfig = {
        Audience = "netbird";
        # Audience = "netbird-client";
        ClientID = "netbird-client";
        ClientSecret = "";
        Domain = "";
        AuthorizationEndpoint = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/auth";
        TokenEndpoint = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/token";
        Scope = "openid profile email offline_access api";
        RedirectURLs = [
          "http://localhost:53000"
          "https://netbird.schwem.io/*"
        ];
        # UseIDToken = false;
      };
    };
  };
}
