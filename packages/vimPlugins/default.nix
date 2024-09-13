pkgs: {
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompanion-nvim";
    src = pkgs.fetchFromGitHub {
      "owner" = "olimorris";
      "repo" = "codecompanion.nvim";
      "rev" = "a5780c363e70310f06f4f5903097090e193211bf";
      "hash" = "sha256-iLV9pJC+wzBAw2mOXnELLKUJf2bFBd5jFOwhzh12s2g=";
    };
  };
}
