{ pkgs, ... }:
{
  home.packages = with pkgs; [ gh ];
  programs.git = {

    enable = true;
    lfs.enable = true;

    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;

      alias = {
        b = "branch";
        bd = "branch --delete";
        cb = "checkout --branch";
        co = "checkout";
        cm = "!git add . && git commit -am";
        s = "status";
      };

      core = {
        whitespace = "trailing-space,space-before-tab";
      };

      user = {
        email = "tjschwem@gmail.com";
        name = "Tyler Schwemley";
      };

      url = {
        "ssh://forgejo" = {
          insteadOf = "https://git.schwem.io";
        };
      };
    };

    ignores = [
      ".aider*"
      ".direnv/"
      ".env"
      "openrouter-usage*json"
    ];
  };
}
