{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    histSize = 10000;
    histFile = "$HOME/.zsh_history";
    #shellAliases = shellAliases;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [pkgs.zsh];
}
