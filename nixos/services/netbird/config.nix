{config, ...}: let 
  turnDomain = "localhost"; 
in
{
  sops.secrets.netbirdBackendSecret = {
    sopsFile = ./secrets.yaml;
  };

  sops.templates.netbirdMgmtConfig.content = builtins.toJSON {
    Signal = {
      Proto = "http";
      URI = "netbird.schwem.io:10000";
      # Username = "";
      # Password = null;
    };
    # Datadir = "";
    # DataStoreEncryptionKey = "$NETBIRD_DATASTORE_ENC_KEY";
    # StoreConfig = {
    #   Engine = "$NETBIRD_STORE_CONFIG_ENGINE";
    # };
    HttpConfig = {
      Address = "0.0.0.0:$NETBIRD_MGMT_API_PORT";
      AuthAudience = "netbird-client";
      OIDCConfigEndpoint = "https://auth.schwem.io/realms/netbird/.well-known/openid-configuration";
      # AuthIssuer = "$NETBIRD_AUTH_AUTHORITY";
      # AuthKeysLocation = "$NETBIRD_AUTH_JWT_CERTS";
      # AuthUserIDClaim = "$NETBIRD_AUTH_USER_ID_CLAIM";
      # CertFile = "$NETBIRD_MGMT_API_CERT_FILE";
      # CertKey = "$NETBIRD_MGMT_API_CERT_KEY_FILE";
      # IdpSignKeyRefreshEnabled = "$NETBIRD_MGMT_IDP_SIGNKEY_REFRESH";
    };
    IdpManagerConfig = {
      ManagerType = "keycloak";
      ClientConfig = {
        ClientID = "netbird-backend";
        ClientSecret = config.sops.placeholder.netbirdBackendSecret;
        GrantType = "client_credentials";
        # Issuer = "$NETBIRD_AUTH_AUTHORITY";
        TokenEndpoint = "https://auth.schwem.io/realms/netbird/protocol/openid-connect/token";
      };
      # ExtraConfig = "$NETBIRD_IDP_MGMT_EXTRA_CONFIG";
      # Auth0ClientCredentials = null;
      # AzureClientCredentials = null;
      # KeycloakClientCredentials = null;
      # ZitadelClientCredentials = null;
    };
    DeviceAuthorizationFlow = {
      Provider = "none";
      ProviderConfig = {
        AuthorizationEndpoint = "";
        ClientID = "netbird-client";
        ClientSecret = "";
        # Audience = "$NETBIRD_AUTH_DEVICE_AUTH_AUDIENCE";
        # TokenEndpoint = "$NETBIRD_AUTH_TOKEN_ENDPOINT";
        # Domain = "$NETBIRD_AUTH0_DOMAIN";
        # DeviceAuthEndpoint = "$NETBIRD_AUTH_DEVICE_AUTH_ENDPOINT";
        # Scope = "$NETBIRD_AUTH_DEVICE_AUTH_SCOPE";
        # UseIDToken = "$NETBIRD_AUTH_DEVICE_AUTH_USE_ID_TOKEN";
        # RedirectURLs = null;
      };
    };
    PKCEAuthorizationFlow = {
      ProviderConfig = {
        ClientID = "netbird-client";
        ClientSecret = "$NETBIRD_AUTH_CLIENT_SECRET";
        Scope = "openid profile email offline_access api";
        # Audience = "$NETBIRD_AUTH_PKCE_AUDIENCE";
        # Domain = "";
        # AuthorizationEndpoint = "$NETBIRD_AUTH_PKCE_AUTHORIZATION_ENDPOINT";
        # TokenEndpoint = "$NETBIRD_AUTH_TOKEN_ENDPOINT";
        # RedirectURLs = "[$NETBIRD_AUTH_PKCE_REDIRECT_URLS]";
        # UseIDToken = "$NETBIRD_AUTH_PKCE_USE_ID_TOKEN";
      };
    };
    Stuns = [
      {
        "Proto" = "udp";
        "URI" = "stun:${turnDomain}:3478";
        "Username" = "";
        "Password" = null;
      }
    ];
    TURNConfig = {
      Turns = [
        {
          Proto = "udp";
          URI = "turn:${turnDomain}:3478";
          # Username = "$TURN_USER";
          # Password = "$TURN_PASSWORD";
        }
      ];
      CredentialsTTL = "12h";
      # Secret = "secret";
      TimeBasedCredentials = false;
    };
  };
}
