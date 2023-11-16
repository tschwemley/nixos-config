{
  name,
  email,
  ...
}: let
  aliases = {
    b = "branch";
    cb = "checkout --branch";
    cm = "commit -am";
    s = "status";
  };
in {
  programs.git = {
    inherit aliases;
    enable = true;
    userEmail = name;
    userName = email;
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        whitespace = "trailing-space,space-before-tab";
      };
    };
  };
}
