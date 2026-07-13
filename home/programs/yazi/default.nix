{
  config,
  pkgs,
  ...
}:
{
  # dependencies required by plugins
  home.packages = with pkgs; [
    poppler-utils # pdf preview
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = config.programs.zsh.enable;

    initLua = /* lua */ ''
      require("full-border"):setup {
        -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
        type = ui.Border.ROUNDED,
      }


      th.dupes = th.dupes or {}
      -- th.dupes.mark_style = ui.Style():fg("#FFFFFF")
      th.dupes.mark_style = ui.Style():fg("blue")
      th.dupes.mark_sign = "X"

      -- REF: https://github.com/Mshnwq/dupes.yazi
      require("dupes"):setup {
      	-- Global settings
      	save_op = false,        -- Save results to file by default
      	-- auto_confirm = true, -- Skip confirmation for apply (use with caution!)
      	
      	profiles = {
      		-- Interactive mode: recursively scan and display duplicates
      		interactive = {
      			args = { "-r" },
      		},
      		-- Apply mode: recursively scan and DELETE duplicates
      		apply = {
      			args = { "-r", "-N", "-d" },
      			save_op = true,  -- Save results before deletion
      		},
      		-- Custom profile example (uncomment to use)
      		-- custom = {
      		-- 	args = { "-r", "-s", },  -- Your custom jdupes flags
      		-- },
      	},
      }
    '';

    shellWrapperName = "y"; # old option was "yy"

    keymap = import ./keymap.nix;
    plugins = import ./plugins.nix pkgs.yaziPlugins;
    settings = import ./settings.nix;
  };
}
