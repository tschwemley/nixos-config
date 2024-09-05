{ pkgs, ... }:
{
  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = [ "/share/zsh" ];

  home.sessionVariables = {
    TERM = "xterm-kitty";
  };

  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
      };
    };
  };

  # make zsh default for all users
  users.defaultUserShell = pkgs.zsh;
}
