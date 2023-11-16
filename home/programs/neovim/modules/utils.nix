{pkgs, ...}: let
  rsync-nvim = with pkgs;
    vimUtils.buildVimPlugin {
      pname = "rsync-nvim";
      version = "20230910";
      src = fetchFromGitHub {
        owner = "OscarCreator";
        repo = "rsync.nvim";
        rev = "bc5789e73083692af2a21c72216d0b5985b929e3";
        sha256 = "sha256-nJ0w4SO616RRUbFky+SH2deGh1uuIzF03QmlqdoIgxY=";
      };
    };
in {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    better-escape-nvim
    rsync-nvim
    toggleterm-nvim
    which-key-nvim
  ];
}
