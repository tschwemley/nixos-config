# Architecture
The architecture is as follows:

devshell - contains deafult devshell configurations (devshells are used on a per-project basis)
home - contains items and info typically found in the user-specific home directory (usually $XDG_HOME)
hosts - configurations for systems managed by nix
lib - helper expressions for Nix
modules - contains re-usable modules/components for use in defining system configuration 
users - user configuration


# Inspiration and References
I found myself coming back to a few different repos for inspiration while initially writing the config.

- https://github.com/hlissner/dotfiles/
- https://github.com/Mic92/dotfiles/
- https://github.com/srid/nixos-config/
