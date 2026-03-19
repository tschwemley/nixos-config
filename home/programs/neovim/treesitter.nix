{ pkgs, ... }:
let
  nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
    parser: with parser; [
      astro
      awk
      bash
      cmake
      comment # see: https://github.com/stsewd/tree-sitter-comment
      css
      csv
      diff
      go
      gotmpl
      gomod
      gosum
      html
      http
      ini
      javascript
      jq
      json
      kdl
      lua
      luadoc
      make
      markdown
      markdown_inline
      nix
      php
      python
      regex
      sql
      ssh_config
      superhtml
      templ
      toml
      tsx
      typescript
      vim
      vimdoc
      xml
      yaml
      zig
    ]
  );
in
{
  programs.neovim = {
    extraPackages = [ pkgs.tree-sitter ];

    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      # nvim-treesitter
      # pkgs.vimPlugins.nvim-treesitter-textobjects
    ];
  };
}
