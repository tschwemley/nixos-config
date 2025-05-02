{
  lib,
  ...
}: let
  shellAliases = import ./aliases lib;
in {
  home.file.".zsh_completions".source = ./completions;

  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };
    initContent =
      #bash
      ''
        ${builtins.readFile ./hooks.zsh}
        ${builtins.readFile ./functions.zsh}
      '';
  };
}
