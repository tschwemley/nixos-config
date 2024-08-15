{
  services.keycloak = {
    enable = true;

    database = {
      host = "10.10.1.1";
      passwordFile = "/run/secrets/db_password";
      port = 5432;
      name = "keycloak";
      type = "postgresql";
      username = "keycloak";
      useSSL = false;
    };

    settings = {
      hostname = "auth.schwem.io";
      # this is important to prevent endless loading admin page
      hostname-admin-url = "https://auth.schwem.io";
      proxy = "edge";
      transaction-xa-enable = false;
    };

    # initialAdminPassword = "<set_to_rand_string>"; # change on first login
  };
}
