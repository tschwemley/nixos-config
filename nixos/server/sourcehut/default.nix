{
  services.sourcehut = {
    enable = true;
    git.enable = true;
    hub.enable = true;
    man.enable = true;
    nginx.enable = true;
    pages.enable = true;
    paste.enable = true;
    todo.enable = true;

    settings = {
      "sr.ht" = {
        global-domain = "srht.schwem.io";
      };
    };
  };
}
