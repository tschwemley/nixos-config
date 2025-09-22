{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # NOTE: these are the settings that used to be enabled by default (now deprecated)
    matchBlocks."*" = {
      addKeysToAgent = "no";
      compression = false;
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
      forwardAgent = false;
      hashKnownHosts = false;
      serverAliveCountMax = 3;
      serverAliveInterval = 0;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };
}
