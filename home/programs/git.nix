{
  name,
  email,
  ...
}: {
  programs.git = {
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
