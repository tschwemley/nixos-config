{
  config,
  pkgs,
  ...
}: {
  home.packages = [pkgs.posting];

  home.sessionVariables.POSTING_DIR = "${config.xdg.dataHome}/posting";

  xdg.dataFile."posting/themes/gruvbox-material-dark.yaml".text =
    #yaml
    ''
      # The name to use in your posting 'config.yaml' file
      name: gruvbox-dark-material-hard

      # -----------------
      # Core Semantic Colors
      # Mapping based on the Gruvbox Dark Material (Hard) color scheme.
      # -----------------
      primary: '#7daea3'     # Blue: for buttons, fixed table columns, and primary actions.
      secondary: '#89b482'   # Aqua: for the method selector and other minor labels.
      accent: '#d8a657'      # Yellow: for header text, scrollbars, cursors, and focus highlights.
      background: '#1d2021'  # The main, darkest background color.
      surface: '#3c3836'     # A slightly lighter background for panels, text areas, etc.
      error: '#ea6962'       # Red: for error messages.
      success: '#a9b665'     # Green: for success messages.
      warning: '#d8a657'     # Yellow: for warning messages.

      # -----------------
      # Optional Syntax Highlighting
      # More specific styling for JSON and other syntax-highlighted areas.
      # -----------------
      syntax:
        json_key: '#7daea3'     # Blue
        json_number: '#d3869b'  # Purple
        json_string: '#a9b665'  # Green
        json_boolean: '#d4be98' # Foreground color
        json_null: 'italic #eddeb5' # Italicized light gray

      # -----------------
      # Optional Method Styles
      # Custom styles for HTTP method tags in the collection tree.
      # -----------------
      method:
        get: 'bold #7daea3'     # Blue
        post: 'bold #a9b665'    # Green
        put: 'bold #d8a657'     # Yellow
        patch: 'bold #d8a657'   # Yellow
        delete: 'bold #ea6962'  # Red
    '';
}
