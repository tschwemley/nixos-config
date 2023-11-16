{
  name ? "Tyler Schwemley",
  email ? "tjschwem@gmail.com",
  enableLfs ? true,
  ...
}: {
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
      userEmail = name;
      userName = email;
      lfs.enable = true;
      extraConfig = {
        core = {
          whitespace = "trailing-space,space-before-tab";
        };
      };
    };
  };
}
