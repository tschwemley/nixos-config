## About
TODO: update
Custom written nix flake configuration with standalone home-manager configs. A pinch of inspiration
from other config repos thrown in to add texture.

## Features
TODO: rewrite
- desktop/laptop configurations
- k3s configuration
- standalone home-manager configuration
- secret management via sops
- uses nix flakes
- wireguard site-to-site config

## Why Nix?
TODO

## Architecture
Mirrors the flake.nix format with minor changes for mneomnic reasons. Home-manager config is in
home directory. Xdg config files live in-place with the module(s) that use them.

## Acknowlegements
### Inspiration
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [mic92/dotfiles](https://github.com/mic92/dotfiles)
- [mistero77/nix-config](https://github.com/Misterio77/nix-config)
