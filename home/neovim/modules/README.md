# Neovim Modules
My Neovim modules are organized by concern with plugins that don't quite fit with others and/or are
standalone living inside the plugins directory.

## Module Structure
A module is just a group of plugins (defined inside `programs.neovim.modules`). Plugins in the 
`plugins` directory are configured according to the home-manager [pluginWithConfigType](https://github.com/nix-community/home-manager/blob/2f84579a70b8c74e5ebb37299a0c3ba279f09382/modules/programs/neovim.nix#L16)
definition (hence the submodule typing). Each module defines it's configuration via extraLuaConfig,
with the exception of standalone plugins, which use the `config` option in `pluginWithConfigType`.

## Import Ordering
TODO: fill this out if it matters. Import order in  nix is in reverse array order.
