{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig =
      /*
      lua
      */
      ''
        local wezterm = require 'wezterm'
        local act = wezterm.action

        local config = {
          audible_bell = 'Disabled',
          color_scheme = 'Gruvbox dark, medium (base16)',
          enable_wayland = false,
          font = wezterm.font('Hasklig'),
          font_size = 20,
          keys = {
            {
              key = '%',
              mods = 'CTRL|SHIFT',
              action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
            },
            {
              key = '"',
              mods = 'CTRL|SHIFT',
              action = act.SplitVertical { domain = 'CurrentPaneDomain' },
            },
            {
              key = 'h',
              mods = 'CTRL|SHIFT',
              action = act.ActivatePaneDirection 'Left',
            },
            {
              key = 'l',
              mods = 'CTRL|SHIFT',
              action = act.ActivatePaneDirection 'Right',
            },
            {
              key = 'k',
              mods = 'CTRL|SHIFT',
              action = act.ActivatePaneDirection 'Up',
            },
            {
              key = 'j',
              mods = 'CTRL|SHIFT',
              action = act.ActivatePaneDirection 'Down',
            },
          },
          mouse_bindings = {
            {
              event = { Down = { streak = 1, button = "Right" } },
              mods = "NONE",
              action = wezterm.action_callback(function(window, pane)
                local has_selection = window:get_selection_text_for_pane(pane) ~= ""
                if has_selection then
                  window:perform_action(act.CopyTo("ClipboardAndPrimarySelection"), pane)
                  window:perform_action(act.ClearSelection, pane)
                else
                  window:perform_action(act({ PasteFrom = "Clipboard" }), pane)
                end
              end),
            },
          },
          ssh_domains = wezterm.default_ssh_domains(),
          term = "wezterm",
        }

        for _, dom in ipairs(config.ssh_domains) do
          dom.assume_shell = 'Posix'
        end

        return config
      '';
  };

  # home.sessionVariables = {
  #   TERMINFO_DIRS = "$TERMINFO_DIRS:$HOME/.nix-profile/share/terminfo";
  #   WSLENV = "TERMINFO_DIRS";
  # };
}
