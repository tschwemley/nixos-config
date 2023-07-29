{config, ...}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "(cat /run/secrets/bw_email)";
      pinentry = "tty";
    };
  };
}
