{
  # TODO: audit each of the "modules" and determine which plugins are actually being used and which
  #       can be removed. consider moving away from "modules" pattern to a plugin pattern instead.
  #       also consider separating out lua config to a lua or config dir.
  imports = [
    ./ai
    ./colors
    ./completion
    ./debug
    ./diagnostics
    ./editing
    ./files
    ./lsp
    ./mini
    # ./notes
    ./schwem
    ./telescope
    ./terminal
    ./tools
    ./ui
    ./treesitter
    ./utils
  ];
}
