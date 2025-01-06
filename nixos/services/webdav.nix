{
  services.webdav-server-rs = {
    enable = true;
    settings = {
      server.listen = ["0.0.0.0:4918" "[::]:4918"];
      accounts = {
        # auth-type = "htpasswd.default";
        auth-type = "pam";
        acct-type = "unix";
      };
      # htpasswd.default = {
      #   htpasswd = "/etc/htpasswd";
      # };
      location = [
        {
          route = ["/storage/shh"];
          directory = "/storage/shh";
          handler = "filesystem";
          methods = ["webdav-ro"];
          autoindex = true;
          auth = "true";
        }
        {
          route = ["/storage/shh2"];
          directory = "/storage/shh2";
          handler = "filesystem";
          methods = ["webdav-rw"];
          autoindex = true;
          auth = "true";
          setuid = true;
        }
      ];
    };
  };
}
