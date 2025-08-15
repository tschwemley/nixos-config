{pkgs, ...}: let
	bruno = pkgs.tree-sitter.buildGrammar {
		language = "bruno";
		version = "8af0aab";
		src = pkgs.fetchFromGitHub {
			owner = "Scalamando";
			repo = "tree-sitter-bruno";
			rev = "dd27fe0eff8e7f8184dfc91e426b886dc8369c46";
			sha256 = "sha256-WjA5Y6ZejFlHi5C/Wv56Hqpo/BJ4+vq9VIMSzWrznx4=";
		};
	};

	treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (
		parser:
		with parser;
		[
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
			jsonc
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
		++ [bruno]
	);
in {
	programs.neovim.plugins = [
		treesitter
		pkgs.vimPlugins.nvim-treesitter-textobjects
	];
}
