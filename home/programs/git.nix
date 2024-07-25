{
  pkgs,
  name,
  email,
  ...
}: let
  aliases = {
    b = "branch";
    cb = "checkout --branch";
    co = "checkout";
    cm = "!git add . && git commit -am";
    s = "status";
  };
in {
  home.packages = with pkgs; [gh];
  programs.git = {
    inherit aliases;
    enable = true;
    userEmail = email;
    userName = name;
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      core = {
        whitespace = "trailing-space,space-before-tab";
      };
    };
  };
}
