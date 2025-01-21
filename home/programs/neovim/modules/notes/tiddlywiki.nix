{pkgs, ...}: let
  vim-tiddlywiki = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tiddlywiki";
    src = pkgs.fetchFromGitHub {
      "owner" = "sukima";
      "repo" = "vim-tiddlywiki";
      "rev" = "master";
      "hash" = "sha256-5oKndDeSO362s7LlHWSezGIK7F2+uMAY9gRCOFxSzMY=";
    };
  };
in {
  programs.neovim.plugins = [vim-tiddlywiki];

  xdg.configFile."nvim/after/plugin/debug/tiddlywiki.lua".text =
    /*
    lua
    */
    ''
      -- Explicitly set the username of the tiddler 'creator' and 'modifier'
      -- If not set, this defaults to `$USER` or `$LOGNAME` (in that order)
      vim.g.tiddlywiki_author = 'schwem'

      -- Specify the location of your tiddlers. The subdir "tiddlers" is appended
      -- automatically if required.
      vim.g.tiddlywiki_dir = '~/tiddlywiki'

      -- Set the date format to use for journal tiddlers, as in the format string of date(1).
      -- This does not have to be at 'day' granularity - you can also use
      -- months / weeks / hours / whatever makes sense to you.
      -- Defaults to '%F' (ISO date = yyyy-mm-dd)
      -- vim.g.tiddlywiki_journal_format = '%A, %F (Week %V)'

      -- Disable the default mappings
      vim.g.tiddlywiki_no_mappings = 1

      -- Automatically update tiddler metadata ('modified' timestamp, 'modifier'
      -- username) on write
      vim.g.tiddlywiki_autoupdate = 1
    '';
}
