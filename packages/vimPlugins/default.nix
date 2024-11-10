pkgs: {
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompanion-nvim";
    src = pkgs.fetchFromGitHub {
      "owner" = "olimorris";
      "repo" = "codecompanion.nvim";
      "rev" = "v9.5.0";
      "hash" = "sha256-r+PKDMJQZZ40MXg0XlWCLwPTWUUa1YrdNrOm9rYGa0Q=";
    };
  };
  vlog = pkgs.vimUtils.buildVimPlugin {
    name = "vlog-nvim";
    src = pkgs.fetchFromGitHub {
      "owner" = "tjdevries";
      "repo" = "vlog.nvim";
      "rev" = "master";
      "hash" = "sha256-DeJXUIKMi0hxYHFffg2gwoYJbT7z+stu2ElaeRbcImA=";
    };
  };
}
