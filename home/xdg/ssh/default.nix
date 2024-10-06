{
  imports = [ ./servers.nix ];

  programs.ssh = {
    enable = true;
  };
}
