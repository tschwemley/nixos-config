{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    settings."*" = {
      AddKeysToAgent = "no";
      Compression = false;
      ControlMaster = "no";
      ControlPath = "~/.ssh/master-%r@%n:%p";
      ControlPersist = "no";
      ForwardAgent = false;
      HashKnownHosts = false;
      IdentitiesOnly = true;
      ServerAliveCountMax = 3;
      ServerAliveInterval = 0;
      UserKnownHostsFile = "~/.ssh/known_hosts";
    };
  };
}
