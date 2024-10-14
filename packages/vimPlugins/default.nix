pkgs: {
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompanion-nvim";
    src = pkgs.fetchFromGitHub {
      "owner" = "olimorris";
      "repo" = "codecompanion.nvim";
      "rev" = "v8.3.1";
      "hash" = "sha256-2uTdh1TdXvIEosjf90caApR/tNNX5xJJKTgfCCEnDjs=";
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
