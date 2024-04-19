pkgs:
with pkgs.vimPlugins;
  nvim-treesitter.withPlugins (p: [
    p.astro
    p.awk
    p.bash
    p.cmake
    # p.comment
    p.css
    p.csv
    p.diff
    p.go
    p.gomod
    p.gosum
    p.html
    p.http
    p.ini
    p.javascript
    p.jq
    p.json
    p.jsonc
    p.lua
    p.luadoc
    p.make
    p.markdown
    p.markdown_inline
    p.nix
    p.norg
    p.php
    p.python
    p.sql
    p.ssh_config
    p.toml
    p.tsx
    p.typescript
    p.vimdoc
    p.xml
    p.yaml
    p.zig
  ])
# TODO: add haxe

