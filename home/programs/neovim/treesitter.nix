{ pkgs, ... }:
{
  programs.neovim = with pkgs; {
    extraPackages = [ tree-sitter ];

    plugins = with pkgs.vimPlugins; [
      nvim-treesitter-context
      nvim-treesitter-textobjects

      (nvim-treesitter.withPlugins (
        p: with p; [
          bash
          # comment
          cpp
          go
          javascript
          json
          json5
          kdl
          lua
          nix
          php
          python
          rust
          toml
          typescript
          xml
          yaml
          zsh
        ]
      ))
    ];
  };
}
