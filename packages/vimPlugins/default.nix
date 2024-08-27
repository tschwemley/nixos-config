pkgs: {
  codecompanion = pkgs.vimUtils.buildVimPlugin {
    name = "codecompanion-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "olimorris";
      repo = "codecompanion.nvim";
      rev = "5f53f6f71c544f1e277cc6aba705f5843108a307";
      hash = "sha256-Sd1Kl2kSW5mpmyLVfmEOP7MagiP5tqxtF0HJqvK97vY=";
    };
  };
}
