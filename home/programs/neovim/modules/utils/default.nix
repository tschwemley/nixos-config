{pkgs, ...}: let
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
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    mini-nvim
    neogit-nightly
    nnn-vim
  ];

  xdg.configFile."nvim/after/plugin/mini-clue.lua".source = ./mini-clue.lua;
  xdg.configFile."nvim/after/plugin/neogit.lua".source = ./neogit.lua;
  xdg.configFile."nvim/after/plugin/nnn.lua".source = ./nnn.lua;
}
