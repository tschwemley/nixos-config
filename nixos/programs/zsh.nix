{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
    };
  };

  # make zsh default for all users
  users.defaultUserShell = pkgs.zsh;
}
