{pkgs, ...}: {
  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = ["/share/zsh"];

  programs = {
    # TODO: needed?
    # less.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        # TODO: not sure if I want to keep the coloring
        patterns = {"rm -rf *" = "fg=black,bg=red";};
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
    };
  };

  # TODO: needed?
  # users.defaultUserShell = pkgs.zsh;
}
