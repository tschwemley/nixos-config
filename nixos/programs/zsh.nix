{pkgs, ...}: {
  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = ["/share/zsh"];

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      syntaxHighlighting = {
        enable = true;
      };
    };
  };

  # make zsh default for all users
  users.defaultUserShell = pkgs.zsh;
}
