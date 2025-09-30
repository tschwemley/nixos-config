{ pkgs, ... }:
let
  aliases = {
    b = "branch";
    bd = "branch --delete";
    cb = "checkout --branch";
    co = "checkout";
    cm = "!git add . && git commit -am";
    s = "status";
  };
in
{
  home.packages = with pkgs; [ gh ];
  programs.git = {
    inherit aliases;

    enable = true;
    lfs.enable = true;
    userEmail = "tjschwem@gmail.com";
    userName = "Tyler Schwemley";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core = {
        whitespace = "trailing-space,space-before-tab";
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
