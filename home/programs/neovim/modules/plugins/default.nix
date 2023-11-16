{
  vimPlugins,
  submodule,
}: let
  betterEscape = import ./better-escape.nix {inherit vimPlugins;};
  comment = import ./comment.nix {inherit vimPlugins;};
in {
  programs.neovim.plugins = with submodule; [
    betterEscape
    comment
  ];
}
