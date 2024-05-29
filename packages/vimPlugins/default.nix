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
  harpoon = pkgs.vimUtils.buildVimPlugin {
    name = "harpoon";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "harpoon";
      rev = "harpoon2";
      hash = "sha256-FZQH38E02HuRPIPAog/nWM55FuBxKp8AyrEldFkoLYk=";
    };
  };
  # NOTE: this is only necessary until official 0.10 support hits neogit master
  neogit-nightly = pkgs.vimUtils.buildVimPlugin {
    name = "neogit-nightly";
    src = pkgs.fetchFromGitHub {
      owner = "NeogitOrg";
      repo = "neogit";
      rev = "89c7842b5998c5b5552b3da388ce4f4320f59565";
      hash = "sha256-PwSckn4Mo0uaiUN/aiH7ic7W3QVUQ52j1BdVA1CWVbs=";
    };
  };
}
