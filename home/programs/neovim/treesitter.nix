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
          html
          javascript
          json
          json5
          kdl
          lua
          nix
          php
          python
          regex
          rust
          sql
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
