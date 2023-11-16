{
  config,
  pkgs,
  ...
}: let
  shellAliases = import ./shell-aliases;
in {
  programs.zsh = {
    inherit shellAliases;
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };
  };
}
