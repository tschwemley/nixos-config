{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      UseDns = true;
    };
  };
}
