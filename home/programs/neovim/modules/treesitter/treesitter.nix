pkgs:
with pkgs.vimPlugins;
  nvim-treesitter.withPlugins (parser: [
    parser.astro
    parser.awk
    parser.bash
    parser.cmake
    # parser.comment
    parser.css
    parser.csv
    parser.diff
    parser.go
    parser.gomod
    parser.gosum
    parser.html
    parser.http
    parser.ini
    parser.javascript
    parser.jq
    parser.json
    parser.jsonc
    parser.lua
    parser.luadoc
    parser.make
    parser.markdown
    parser.markdown_inline
    parser.nix
    parser.norg
    parser.php
    parser.python
    parser.sql
    parser.ssh_config
    parser.toml
    parser.tsx
    parser.typescript
    parser.vimdoc
    parser.xml
    parser.yaml
    parser.zig
  ])
# TODO: add haxe

