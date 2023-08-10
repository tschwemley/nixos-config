{
  config,
  pkgs,
  ...
}: let
  shellAliases = import ./aliases;
in{
  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autocd = true;
    defaultKeymap = "emacs";
    enableAutosuggestions = true;
    enableCompletion = true;
    history = {
      expireDuplicatesFirst = true;
      extended = true;
    };
    # TODO: update these to be split when I care enough
    # shellAliases = {
    #   "gco" = "git checkout";
    #   "gcob" = "git checkout -b";
    #   "gcm" = "git cm";
    #   "gl" = "git log";
    # };
  };
}
